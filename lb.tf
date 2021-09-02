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

resource "openstack_lb_loadbalancer_v2" "eredes16-lb" {
  name = "eredes16-lb"
  vip_subnet_id = "bbcfb66e-82f7-4875-a28c-eacc939d78fe"
}
resource "openstack_lb_listener_v2" "listener_1" {
  protocol        = "HTTP"
  protocol_port   = "80"
  loadbalancer_id = openstack_lb_loadbalancer_v2.eredes16-lb.id
}
resource "openstack_lb_pool_v2" "pool_1" {
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.listener_1.id
}
resource "openstack_lb_members_v2" "members_1" {
  pool_id = openstack_lb_pool_v2.pool_1.id

  member {
    address       = "192.168.0.60"
    protocol_port = "80"
  }

  member {
    address       = "192.168.0.69"
    protocol_port = "80"
  }
}
resource "openstack_lb_monitor_v2" "monitor_1" {
  pool_id     = "${openstack_lb_pool_v2.pool_1.id}"
  type        = "PING"
  delay       = 20
  timeout     = 10
  max_retries = 5
}

// Adicionando floating IP EXISTENTE
resource "openstack_networking_floatingip_associate_v2" "fip_1" {
  floating_ip = "143.106.73.37"
  port_id     = "${openstack_lb_loadbalancer_v2.eredes16-lb.vip_port_id}"
}

// Criando um novo floating IP
//resource "openstack_networking_floatingip_v2" "floatip_eredes16" {
//  pool    = "public"
//  port_id = "${openstack_lb_loadbalancer_v2.eredes16-lb.vip_port_id}"
//}