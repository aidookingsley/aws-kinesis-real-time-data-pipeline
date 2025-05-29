# 🌡️ IoT Temperature Monitoring Pipeline

This project simulates temperature readings from IoT devices and streams them in real time using **AWS Kinesis**. The data is processed by an **AWS Lambda** function and stored in **Amazon DynamoDB** for persistent storage and analysis. All cloud resources are provisioned with **Terraform**, while data simulation is handled by a lightweight Python script.

---

## 📁 Project Structure

```
.
├── lambda_func.py
├── README.md
├── terraform
│   ├── iam_policy.tf
|   ├── providers.tf
|   ├── kinesis.tf 
│   ├── lambda.tf
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── iot_simulate_temp.py
└── .gitignore



---

## 🚀 Features

- **Real-time data ingestion** via AWS Kinesis
- **Serverless processing** with AWS Lambda
- **NoSQL persistence** using DynamoDB
- **Infrastructure as Code** with Terraform
- **Python simulator** for generating realistic temperature data

---

## 🔧 Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/aidookingsley/aws-kinesis-real-time-data-pipeline.git
cd aws-kinesis-real-time-datapipeline

2. Set up your Python environment
```
python3 -m venv venv
source venv/bin/activate      # On Windows: venv\Scripts\activate
pip install boto3
```
Tip: Add venv/ to your .gitignore so it isn’t pushed to Git.

3. Configure AWS credentials
Make sure the AWS CLI is installed, then run:
```
aws configure
```
Provide your Access Key ID, Secret Access Key, preferred region (e.g., us-east-1), and desired output format.

4. Deploy AWS infrastructure with Terraform
From the terraform/ directory:
```
terraform init
terraform apply
```
Terraform will provision:

A Kinesis stream (temperature-stream)

A DynamoDB table (TemperatureReadings)

An IAM role with least-privilege policies

A Lambda function wired to the stream trigger

Ensure lambda.zip (containing lambda_func.py) is referenced correctly in main.tf.

5. Simulate IoT data

Back in the project root:
```
python3 iot_simulate_temp.py
```
Random temperature readings will begin streaming into Kinesis, triggering the Lambda function, which stores each reading in DynamoDB.

🧪 Testing & Monitoring

CloudWatch Logs:
Check /aws/lambda/process-temperature-stream to verify the Lambda function is executing without errors.

Common gotchas:

Runtime.ImportModuleError: confirm the handler is set to lambda_func.lambda_handler.

Permission errors: verify the Lambda role has dynamodb:PutItem on your table.

🗃️ DynamoDB Schema
```
Partition Key	Sort Key	Attribute
device_id	timestamp	temperature (Number)
```

📄 .gitignore
```
venv/
__pycache__/
*.pyc
*.zip
.env
.terraform/
terraform.tfstate*
```
🤝 Contributing
Fork the repository

Create a feature branch (git checkout -b feat/amazing-feature)

Commit your changes (git commit -m "Add amazing feature")

Push to the branch (git push origin feat/amazing-feature)

Open a Pull Request

📜 License
This project is licensed under the MIT License. See LICENSE for details.

🧠 Acknowledgements
AWS Documentation — for detailed service guides

Terraform AWS Provider — for IaC modules

📬 Contact
For questions or suggestions, open an issue or reach out to aidookingsleymensah@gmail.com .

