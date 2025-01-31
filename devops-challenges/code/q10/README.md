# For State Locking

```bash
aws s3api create-bucket --bucket techvault-terraform-state --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2

aws dynamodb create-table \
    --table-name techvault-terraform-state-lock \
    --attribute-definitions \
        AttributeName=LockID,AttributeType=S \
    --key-schema \
        AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput \
        ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --region us-west-2
```