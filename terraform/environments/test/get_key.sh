#!/bin/bash
STORAGE_ACCOUNT_NAME="tfstate1140826432"
RESOURCE_GROUP="Azuredevops"

ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP --account-name $STORAGE_ACCOUNT_NAME --query "[0].value" --output tsv)

echo "STORAGE_ACCOUNT_NAME=$STORAGE_ACCOUNT_NAME"
echo "RESOURCE_GROUP=$RESOURCE_GROUP"
echo "ACCOUNT_KEY=$ACCOUNT_KEY"
