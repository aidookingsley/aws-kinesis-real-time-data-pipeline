resource "aws_kinesis_stream" "temperature_stream" {
  name             = "temperature-stream"
  shard_count      = 1
  retention_period = 24
}