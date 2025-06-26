#!/bin/bash

ENV=$1

if [[ -z "$ENV" ]]; then
  echo "Usage: ./bootstrap.sh [dev|stg|prod]"
  exit 1
fi

# Step 1: Bootstrap GCS bucket
echo "🔧 Bootstrapping GCS bucket for Terraform state..."
cd bootstrap || exit
terraform init -input=false
terraform apply -auto-approve -input=false

# Step 2: Get generated bucket name
BUCKET_NAME=$(terraform output -raw bucket_name)
cd ..

echo "✅ Created bucket: $BUCKET_NAME"

# Step 3: Create backend-config-<env>.hcl
CONFIG_FILE="backend-config-$ENV.hcl"
echo "📝 Writing backend config to $CONFIG_FILE"

cat > "$CONFIG_FILE" <<EOL
bucket = "$BUCKET_NAME"
prefix = "terraform/state/$ENV"
EOL

cp $CONFIG_FILE terraform-environments/$ENV/

# Step 4: Run terraform init in environment directory
echo "🚀 Initializing Terraform backend for $ENV environment..."
cd terraform-environments/$ENV || exit
terraform init -backend-config=../../$CONFIG_FILE

echo "🎉 Backend initialized for $ENV using bucket: $BUCKET_NAME"
