variable "region" {
    description = "Region to be used."
    default  = "RegionOne"
}

variable "auth_url" {
    description = "Cloud provider URL."
    default  = "http://cloud.ic.unicamp.br:5000/v3/"
}


variable "user_name" {
    description = "User to authenticate."
    default  = "my_user"
}

variable "tenant" {
    description = "Tenant to authenticate."
    default  = "my_tenant"
}

variable "password" {
    description = "Password to authenticate."
    default  = "my_passwd"
}

variable "network_name" {
    description = "The network to be used."
    default  = "private_and_floating-ip"
}

variable "instance_name" {
    description = "The Instance Name to be used."
    default  = "eredes16"
}

variable "image_id" {
    description = "The image ID to be used."
    default  = "8fee1863-7371-4cd8-a02f-6db15b7114f4"
}

variable "flavor_id" {
    description = "The flavor id to be used."
    default  = "61f182d7-fe3d-4eec-b648-46e5715dc6c6"
}

variable "instance_num" {
    description = "The Number of instances to be created."
    default  = 2
}

variable "security_groups" {
    description = "List of security group"
    type = list
    default = ["default", "eredes16_global_all"]