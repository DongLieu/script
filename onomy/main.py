import json
import sys
import os

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 main.py <path_to_file> <new_priv_key>")
        sys.exit(1)

    file_path = sys.argv[1]
    new_priv_key = sys.argv[2]

    if not os.path.exists(file_path):
        print(f"Error: file '{file_path}' not found")
        sys.exit(1)

    # Đọc file JSON
    with open(file_path, "r") as f:
        data = json.load(f)

    # Thay thế giá trị priv_key.value
    if "priv_key" in data and "value" in data["priv_key"]:
        old_key = data["priv_key"]["value"]
        data["priv_key"]["value"] = new_priv_key
        print(f"Replaced priv_key:\n  old: {old_key}\n  new: {new_priv_key}")
    else:
        print("Error: invalid priv_validator_key.json format")
        sys.exit(1)

    # Ghi lại file
    with open(file_path, "w") as f:
        json.dump(data, f, indent=2)

if __name__ == "__main__":
    main()
