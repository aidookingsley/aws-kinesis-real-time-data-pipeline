import json
import base64
import boto3
from decimal import Decimal

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("TemperatureReadings")

def lambda_handler(event, context):
    for record in event["Records"]:
        payload = base64.b64decode(record["kinesis"]["data"]).decode("utf-8")
        data = json.loads(payload)

        device_id = data["device_id"]
        temperature = Decimal(str(data["temperature"]))
        timestamp = data["timestamp"]

        print(f"Device: {device_id}, Temp: {temperature}, Time: {timestamp}")

        table.put_item(
            Item={
                "device_id": device_id,
                "temperature": temperature,
                "timestamp": timestamp
            }
        )
    return {"statusCode": 200, "body": "Processed records"}