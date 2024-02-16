FROM python:alpine3.19

# Set the working directory in the container
WORKDIR /app

# Copy the script and the JSON template into the container
COPY update_genesis_header.py .
COPY genesis-header.json.template .

RUN pip install requests
# Command to run the script
CMD ["python", "./update_genesis_header.py"]