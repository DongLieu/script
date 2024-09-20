package main

import (
	"fmt"
	"os"
	"path/filepath"
)

const maxSizeMB = 100 // Giới hạn kích thước (100MB)

func main() {
	path := "/Users/donglieu/script"
	err := filepath.Walk(path, func(p string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		// Kiểm tra nếu là file và kích thước lớn hơn 100MB
		if !info.IsDir() && info.Size() > maxSizeMB*1024*1024 {
			fmt.Printf("File: %s, Size: %.2f MB\n", p, float64(info.Size())/1024/1024)
		}
		return nil
	})

	if err != nil {
		fmt.Println("Error:", err)
	}
}
