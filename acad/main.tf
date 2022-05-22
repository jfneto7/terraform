terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

provider "openstack" {
  user_name   = var.user_name
  tenant_name = var.tenant
  password    = var.password
  auth_url    = var.auth_url
  region      = var.region
}

resource "openstack_compute_instance_v2" "eredes16" {
  count = var.instance_num
  name = format("%s-%02d", var.instance_name, count.index+1)
  image_id = var.image_id
  flavor_id = var.flavor_id
  security_groups = var.security_groups
  network {
    name = var.network_name
  }
  user_data = file("bootstrap_jfneto.sh")
}