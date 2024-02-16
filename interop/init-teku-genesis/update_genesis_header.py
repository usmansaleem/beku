import os
import json
import requests
import sys
import shutil

def fetch_genesis_block(retries=5, delay=5):
    url = "http://besu:8545"
    headers = {"Content-Type": "application/json"}
    payload = {
        "jsonrpc": "2.0",
        "method": "eth_getBlockByNumber",
        "params": ["0x0", True],
        "id": 1
    }

    for attempt in range(retries):
        try:
            response = requests.post(url, headers=headers, json=payload)
            response.raise_for_status()  # Raises an HTTPError if the response was an error

            # Convert the response to a JSON object
            response_json = response.json()

            # Pretty-print the JSON response
            print(json.dumps(response_json, indent=4, sort_keys=True))

            return response_json
        except requests.exceptions.RequestException as e:
            print(f"Attempt {attempt + 1} failed with error: {e}")
            if attempt < retries - 1:
                print(f"Retrying in {delay} seconds...")
                time.sleep(delay)
            else:
                print("All attempts failed. Exiting.")
                sys.exit(1)

def update_genesis_file(block_data, file_path):
    try:
        with open(file_path, "r+") as file:
            genesis_data = json.load(file)
            if genesis_data.get("parentHash") == block_data["result"]["parentHash"]:
                print("Parent hash matches. No update needed.")
            else:
                file.seek(0)
                json.dump(block_data, file)
                file.truncate()
                print("genesis-header.json updated.")
    except (json.JSONDecodeError, KeyError) as e:
        print(f"Error updating genesis file: {e}")
        sys.exit(1)

if __name__ == "__main__":
    shared_file_path = "/app/data/genesis-header.json"
    template_file_path = "/app/genesis-header.json.template"

    # Check if the genesis-header.json file already exists in the shared volume
    if not os.path.exists(shared_file_path):
        print("genesis-header.json does not exist in shared volume. Fetching block data and updating...")
        # Fetch block data
        block_data = fetch_genesis_block()
        # Copy and rename the template file to the shared volume
        shutil.copy(template_file_path, shared_file_path)
        # Update the genesis-header.json file with fetched block data
        update_genesis_file(block_data, shared_file_path)
    else:
        print("genesis-header.json already exists in shared volume. Skipping update.")