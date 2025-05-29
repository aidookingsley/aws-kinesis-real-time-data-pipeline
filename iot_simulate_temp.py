import boto3
import json
import random
import time
from datetime import datetime

# AWS Region and Stream
REGION = "us-east-1"
STREAM_NAME = "temperature-stream"

# Initialize Kinesis client
kinesis = boto3.client("kinesis", region_name=REGION)

def generate_temp_event():
    return {
        "device_id": f"device-{random.randint(1, 5)}",
        "temperature": round(random.uniform(20, 80), 2),
        "timestamp": datetime.utcnow().isoformat()
    }

while True:
    event = generate_temp_event()
    print("Sending event:", event)

    kinesis.put_record(
        StreamName=STREAM_NAME,
        Data=json.dumps(event),
        PartitionKey=event["device_id"]
    )

    time.sleep(1)