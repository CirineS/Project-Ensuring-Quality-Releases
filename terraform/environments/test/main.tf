provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
terraform {
  backend "azurerm" {
    storage_account_name = "tfstate1140826432" # number of created tf storage
    container_name       = "tfstate" 
    key                  = "test.terraform.tfstate"
    access_key           = "4sJPOdFcCAMtVPqjL992m3fi9navmDpWZDeXT2+J2zDVwA5PYJAV0iHBTvSS3FuttrcPpZubuAXN+AStgWEM4Q==" # access key provided by the created tf storage
  }
}
module "resource_group" {
  source               = "../../modules/resource_group"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
}
module "network" {
  source               = "../../modules/network"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  application_type     = "${var.application_type}"
  resource_type        = "NET"
  resource_group       = "${module.resource_group.resource_group_name}"
  address_prefix_test  = "${var.address_prefix_test}"
}

module "nsg-test" {
  source           = "../../modules/networksecuritygroup"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "NSG"
  resource_group   = "${module.resource_group.resource_group_name}"
  subnet_id        = "${module.network.subnet_id_test}"
  address_prefix_test = "${var.address_prefix_test}"
}
module "appservice" {
  source           = "../../modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "AppService"
  resource_group   = "${module.resource_group.resource_group_name}"
}
module "publicip" {
  source           = "../../modules/publicip"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "publicip"
  resource_group   = "${module.resource_group.resource_group_name}"
}

module "vm" {
  source               = "../../modules/vm"
  location             = "${var.location}"
  resource_group       = "${module.resource_group.resource_group_name}"
  application_type     = "${var.application_type}"
  subnet_id            = "${module.network.subnet_id_test}"
  vm_admin_username    = "${var.vm_admin_username}"
  public_ip_address_id = "${module.publicip.public_ip_address_id}"
  packer_image         = "${var.packer_image}"
  vm_size              =  "Standard_B1s"
  resource_type        =  "webapp"
}