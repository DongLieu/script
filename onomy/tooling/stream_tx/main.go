package main

import (
	"bytes"
	"context"
	"encoding/base64"
	"encoding/hex"
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"net/http"
	"os"
	"time"
)

type rpcRequest struct {
	JSONRPC string   `json:"jsonrpc"`
	ID      int      `json:"id"`
	Method  string   `json:"method"`
	Params  []string `json:"params"`
}

type rpcError struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
}

type tmTxResult struct {
	Code uint32 `json:"code"`
	Log  string `json:"log"`
}

type rpcResult struct {
	Hash      string     `json:"hash"`
	CheckTx   tmTxResult `json:"check_tx"`
	DeliverTx tmTxResult `json:"deliver_tx"`
}

type rpcResponse struct {
	JSONRPC string     `json:"jsonrpc"`
	ID      int        `json:"id"`
	Result  *rpcResult `json:"result"`
	Error   *rpcError  `json:"error"`
}

type restBroadcastRequest struct {
	TxBytes string `json:"tx_bytes"`
	Mode    string `json:"mode"`
}

type restTxResponse struct {
	Height    string `json:"height"`
	TxHash    string `json:"txhash"`
	Code      uint32 `json:"code"`
	Codespace string `json:"codespace"`
	Data      string `json:"data"`
	RawLog    string `json:"raw_log"`
	GasWanted string `json:"gas_wanted"`
	GasUsed   string `json:"gas_used"`
}

type restBroadcastResponse struct {
	TxResponse restTxResponse `json:"tx_response"`
}

func broadcastTxCommit(ctx context.Context, endpoint, signedTxB64 string) (*rpcResult, error) {
	rawTx, err := base64.StdEncoding.DecodeString(signedTxB64)
	if err != nil {
		return nil, fmt.Errorf("decode base64: %w", err)
	}

	reqBody := rpcRequest{
		JSONRPC: "2.0",
		ID:      1,
		Method:  "broadcast_tx_commit",
		Params:  []string{fmt.Sprintf("0x%s", hex.EncodeToString(rawTx))},
	}

	bodyBytes, err := json.Marshal(reqBody)
	if err != nil {
		return nil, fmt.Errorf("marshal request: %w", err)
	}

	httpReq, err := http.NewRequestWithContext(ctx, http.MethodPost, endpoint, bytes.NewReader(bodyBytes))
	if err != nil {
		return nil, fmt.Errorf("build request: %w", err)
	}
	httpReq.Header.Set("Content-Type", "application/json")

	resp, err := http.DefaultClient.Do(httpReq)
	if err != nil {
		return nil, fmt.Errorf("post request: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		body, _ := io.ReadAll(resp.Body)
		return nil, fmt.Errorf("non-200 response (%d): %s", resp.StatusCode, string(body))
	}

	var rpcResp rpcResponse
	if err := json.NewDecoder(resp.Body).Decode(&rpcResp); err != nil {
		return nil, fmt.Errorf("decode response: %w", err)
	}

	if rpcResp.Error != nil {
		return nil, fmt.Errorf("rpc error %d: %s", rpcResp.Error.Code, rpcResp.Error.Message)
	}

	return rpcResp.Result, nil
}

func broadcastTxREST(ctx context.Context, endpoint, signedTxB64, mode string) (*restTxResponse, error) {
	reqBody := restBroadcastRequest{
		TxBytes: signedTxB64,
		Mode:    mode,
	}

	bodyBytes, err := json.Marshal(reqBody)
	if err != nil {
		return nil, fmt.Errorf("marshal request: %w", err)
	}

	httpReq, err := http.NewRequestWithContext(ctx, http.MethodPost, endpoint, bytes.NewReader(bodyBytes))
	if err != nil {
		return nil, fmt.Errorf("build request: %w", err)
	}
	httpReq.Header.Set("Content-Type", "application/json")

	resp, err := http.DefaultClient.Do(httpReq)
	if err != nil {
		return nil, fmt.Errorf("post request: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		body, _ := io.ReadAll(resp.Body)
		return nil, fmt.Errorf("non-200 response (%d): %s", resp.StatusCode, string(body))
	}

	var restResp restBroadcastResponse
	if err := json.NewDecoder(resp.Body).Decode(&restResp); err != nil {
		return nil, fmt.Errorf("decode response: %w", err)
	}

	if restResp.TxResponse.Code != 0 {
		return &restResp.TxResponse, fmt.Errorf("broadcast failed with code %d: %s", restResp.TxResponse.Code, restResp.TxResponse.RawLog)
	}

	return &restResp.TxResponse, nil
}

func main() {
	var (
		transport    = flag.String("transport", "rest", "Broadcast transport: rest or rpc")
		rpcEndpoint  = flag.String("rpc-endpoint", "http://localhost:26657", "Tendermint RPC endpoint")
		restEndpoint = flag.String("rest-endpoint", "http://localhost:1317/cosmos/tx/v1beta1/txs", "Cosmos REST endpoint")
		restMode     = flag.String("rest-mode", "BROADCAST_MODE_SYNC", "REST broadcast mode")
		timeout      = flag.Duration("timeout", 5*time.Second, "Request timeout")
	)
	flag.Parse()

	if flag.NArg() != 1 {
		fmt.Fprintf(os.Stderr, "Usage: %s [flags] <BASE64_TX_BYTES>\n", os.Args[0])
		flag.PrintDefaults()
		os.Exit(1)
	}

	signedTxB64 := flag.Arg(0)

	ctx, cancel := context.WithTimeout(context.Background(), *timeout)
	defer cancel()

	switch *transport {
	case "rpc":
		result, err := broadcastTxCommit(ctx, *rpcEndpoint, signedTxB64)
		if err != nil {
			fmt.Fprintf(os.Stderr, "broadcast via RPC failed: %v\n", err)
			os.Exit(1)
		}
		fmt.Printf("tx hash: %s\ncheckTx: %+v\ndeliverTx: %+v\n", result.Hash, result.CheckTx, result.DeliverTx)
	case "rest":
		fmt.Println("hay xem nay")
		resp, err := broadcastTxREST(ctx, *restEndpoint, signedTxB64, *restMode)
		if resp != nil {
			fmt.Printf("tx hash: %s\ncode: %d\nraw log: %s\n", resp.TxHash, resp.Code, resp.RawLog)
		}
		if err != nil {
			fmt.Fprintf(os.Stderr, "broadcast via REST failed: %v\n", err)
			os.Exit(1)
		}
	default:
		fmt.Fprintf(os.Stderr, "unknown transport %q (expected rest or rpc)\n", *transport)
		os.Exit(1)
	}
}
