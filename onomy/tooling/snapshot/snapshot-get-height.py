import sys

def parse_snapshot_list(file_path: str):
    snapshots = []
    with open(file_path, "r") as f:
        content = f.read().strip()

    # Tách theo "height:"
    parts = content.split("height:")
    for p in parts[1:]:  # bỏ phần đầu rỗng
        tokens = p.strip().split()
        height = int(tokens[0])
        format_ = tokens[2]
        chunks = tokens[4]
        snapshots.append({"height": height, "format": format_, "chunks": chunks})
    return snapshots

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Usage: python3 {sys.argv[0]} <snapshot-list.txt file path> <height|format|chunks>")
        sys.exit(1)

    command = sys.argv[2]
    snapshots = parse_snapshot_list(sys.argv[1])

    if not snapshots:
        print("No snapshots found")
        sys.exit(1)

    # Lấy snapshot có height lớn nhất
    latest = max(snapshots, key=lambda s: s["height"])

    if command not in latest:
        print(f"Invalid command: {command}")
        sys.exit(1)

    print(latest[command])
