# Description
3 separate local modules: compute (EC2), database (RDS), networking (VPC, subnets, security groups, etc.).

Networking output feeds back into Terraform root file then into other modules. 

RDS uses secrets found in `terraform.tfvars` in root directory.

Basic outputs for the deployment can be found in the root directory.

State locking is separate from the Terraform deployment.

# Basic usage
```
# If first time setting up
terraform init

terraform plan -out .tfplan
terraform apply .tfplan
```

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

# Additional Notes

- Consider using separate security group rules instead of inline rules.
- Use workspaces or change file layout to support different environments.