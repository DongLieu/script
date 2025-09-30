import json
import sys
import os

def get_validators_info(file_path: str, home_tooling: str):
    # Đọc file JSON
    with open(file_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    # Lấy danh sách validators
    validators = data.get("validators", [])

    # Đếm số lượng
    count = len(validators)

    # Lấy danh sách value pubkey
    pubkeys = [v["pub_key"]["key"] for v in validators if "pub_key" in v]
    
    # Thay thế priv_validator_key.json cho từng validator
    for i in range(count):
        # $HOME/.onomyd-tooling/validator{i}/config/priv_validator_key.json
        path_edit = os.path.join(home_tooling, f"validator{i+1}", "config", "priv_validator_key.json")
        editpubkey(path_edit, pubkeys[i])

    return count, pubkeys

def editpubkey(file_path: str, new_pub_key: str):
    if not os.path.exists(file_path):
        # print(f"Error: file '{file_path}' not found")
        sys.exit(1)

    # Đọc file JSON
    with open(file_path, "r") as f:
        data = json.load(f)

    # Thay thế giá trị pub_key.value
    if "pub_key" in data and "value" in data["pub_key"]:
        old_key = data["pub_key"]["value"]
        data["pub_key"]["value"] = new_pub_key
        # print(f"Replaced pub_key:\n  old: {old_key}\n  new: {new_pub_key}")
    else:
        # print("Error: invalid priv_validator_key.json format")
        sys.exit(1)

    # Ghi lại file
    with open(file_path, "w") as f:
        json.dump(data, f, indent=2)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Usage: python3 {sys.argv[0]} <json-file> <home-tooling>")
        sys.exit(1)

    file_path = sys.argv[1]
    home_tooling = sys.argv[2]

    count, pubkeys = get_validators_info(file_path, home_tooling)
    print(count)