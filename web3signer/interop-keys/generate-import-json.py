import os
import json

# Directories containing the JSON files
keystore_directory = './keys'
password_directory = './passwords'
slashing_protection_file = './interchange.json'
output_file = './interop-keys-import.json'

# Lists to store the data
keystores = []
passwords = []

# Iterate over each file in the keystore directory
for filename in os.listdir(keystore_directory):
    if filename.endswith('.json'):
        with open(os.path.join(keystore_directory, filename), 'r') as f:
            data = json.load(f)

            # Append the keystore data to the list
            keystores.append(json.dumps(data))

        # Get the corresponding password file
        password_filename = filename.rsplit('.', 1)[0] + '.txt'
        password_filepath = os.path.join(password_directory, password_filename)

        # Check if the password file exists
        if os.path.isfile(password_filepath):
            with open(password_filepath, 'r') as f:
                password = f.read().strip()

                # Append the password data to the list
                passwords.append(password)

# Check if the slashing protection file exists
if os.path.isfile(slashing_protection_file):
    with open(slashing_protection_file, 'r') as f:
        slashing_protection = json.dumps(json.load(f))
else:
    slashing_protection = ""

# Create the final dictionary
final_dict = {
    'keystores': keystores,
    'passwords': passwords,
    'slashing_protection': slashing_protection
}

# Write the final dictionary to a new JSON file
with open(output_file, 'w') as f:
    json.dump(final_dict, f, indent=2)
