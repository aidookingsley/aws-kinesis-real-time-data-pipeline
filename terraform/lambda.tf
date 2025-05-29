data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = "${path.module}/../lambda_func.py"
  output_path = "${path.module}/../lambda_func.zip"
}

resource "aws_lambda_function" "temperature_processor" {
  function_name    = "process-temperature-stream"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_func.lambda_handler"
  runtime          = "python3.11"
  timeout          = 10
  memory_size      = 128
  filename         = data.archive_file.lambda_package.output_path
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
  depends_on       = [aws_iam_role_policy_attachment.lambda_dynamodb]
}

resource "aws_lambda_event_source_mapping" "kinesis_trigger" {
  event_source_arn  = aws_kinesis_stream.temperature_stream.arn
  function_name     = aws_lambda_function.temperature_processor.arn
  starting_position = "LATEST"
  batch_size        = 10
  depends_on        = [aws_lambda_function.temperature_processor]
}
