resource "aws_iam_role" "lambda_role" {
  name = "lambda-kinesis-temperature-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_kinesis" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisReadOnlyAccess"
}

resource "aws_iam_policy" "ddb_put_only" {
  name = "lambda-temperature-putitem"
  description = "PutItem only on TemperatureReadings table"
  policy = jsonencode({
    Version: "2012-10-17",
    Statement : [{
      Effect : "Allow",
      Action : ["dynamodb:PutItem"],
      Resource : "arn:aws:dynamodb:us-east-1:875607160451:table/TemperatureReadings"
    }]
  })
}

resource "aws_iam_policy_attachment" "ddb_put_only_attach" {
  name       = "ddb-put-only-attach"
  policy_arn = aws_iam_policy.ddb_put_only.arn
  roles      = [aws_iam_role.lambda_role.name]
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}
