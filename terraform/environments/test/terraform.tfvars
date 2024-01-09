# Azure subscription vars
subscription_id = "a785336a-35d8-4efd-80be-93d34a9e4b66"
tenant_id = "f958e84a-92b8-439f-a62d-4f45996b6d07"
client_id = "3782fb39-fc4b-4db3-940c-cd9f7311b80e" # application id / service principal id
client_secret = "Ina8Q~jSB3XTf5X7c_JvZZjsEs14EUTR1Q8SXbMS" # secret key

# Resource Group/Location
location = "westeurope"
resource_group = "Azuredevops"
application_type = "MyApp"

# Network
virtual_network_name = "udacity-ensuring-quality-releases-vnet"
address_space = ["10.5.0.0/16"]
address_prefix_test = "10.5.1.0/24"

# VM
vm_admin_username = "adminuser"
packer_image = "/subscriptions/a785336a-35d8-4efd-80be-93d34a9e4b66/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/packer-image"