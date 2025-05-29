resource "aws_dynamodb_table" "temperature_readings" {
  name         = "TemperatureReadings"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "device_id"

  attribute {
    name = "device_id"
    type = "S"
  }
}