FROM python:alpine3.19

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the script and the JSON template into the container
COPY modify_json.py .
COPY execution-genesis.json.template .

# Command to run the script
CMD ["python", "./modify_json.py"]