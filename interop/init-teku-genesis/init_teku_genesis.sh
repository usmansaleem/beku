#! /bin/sh

# Path to the marker file indicating Teku has already been initialized
TEKU_MARKER_FILE="/usr/src/shared/teku_genesis_initialized.marker"

# Path to the genesis time file created by init-besu-genesis
GENESIS_TIME_FILE="/usr/src/app/genesis_time.txt"

OUTPUT_FILE="/usr/src/shared/custom-genesis.ssz"

# Check if Teku has already been initialized
if [ ! -f "$TEKU_MARKER_FILE" ]; then
    # Teku has not been initialized, proceed with the command
    GENESIS_TIME=$(cat $GENESIS_TIME_FILE)
    # Change ownership of the shared folder because we custom-genesis will be read by Teku later on
    chown -R teku:teku /usr/src/shared
    # Ensure the output file is written to the shared volume
    /opt/teku/bin/teku genesis mock --output-file $OUTPUT_FILE --network /etc/teku/network-config.yaml --validator-count 256 --genesis-time $GENESIS_TIME

    # Mark Teku as initialized to prevent future execution
    touch "$TEKU_MARKER_FILE"
    echo "Teku mock genesis created."
else
    echo "Teku mock genesis already been initialized. Skipping."
fi