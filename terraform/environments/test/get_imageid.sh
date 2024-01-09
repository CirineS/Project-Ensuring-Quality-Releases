#!/bin/bash
# Set your Azure subscription ID and resource group name
subscription_id="a785336a-35d8-4efd-80be-93d34a9e4b66"
resource_group="Azuredevops"
image_name="packer-image"

# Get the image ID
image_id=$(az image show --subscription $subscription_id --resource-group $resource_group --name $image_name --query id --output tsv)

# Display the image ID
echo "Source Image ID: $image_id"