output "kinesis_stream_name" {
  value = aws_kinesis_stream.temperature_stream.name
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.temperature_readings.name
}

output "lambda_role_name" {
  value = aws_iam_role.lambda_role.name
}