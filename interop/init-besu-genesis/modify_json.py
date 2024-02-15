import json
import os
import time

# Note: Adjusted paths to write directly to the mounted volume
marker_file = "/usr/src/shared/first_run_complete.marker"
output_file = "/usr/src/shared/execution-genesis.json"
template_file = "execution-genesis.json.template"  # This remains local to the container

# Check if it's the first run
if not os.path.exists(marker_file):
    current_time = int(time.time())
    genesis_time = current_time + 60
    shanghai_time = genesis_time + 24
    cancun_time = genesis_time + 48

    # Print out the calculated times
    print(f"Genesis Time: {genesis_time}")
    print(f"Shanghai Time: {shanghai_time}")
    print(f"Cancun Time: {cancun_time}")

    with open(template_file, "r") as file:
        data = json.load(file)

    data["config"]["shanghaiTime"] = shanghai_time
    data["config"]["cancunTime"] = cancun_time

    with open(output_file, "w") as file:
        json.dump(data, file, indent=4)

    with open(marker_file, "w") as file:
        file.write(str(genesis_time))

    print("Besu genesis generated successfully.")
else:
    print("Besu genesis already generated, skipping.")
