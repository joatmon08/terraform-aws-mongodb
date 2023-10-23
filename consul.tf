resource "consul_service" "database" {
  name = "${var.business_unit}-database"
  node = consul_node.database.name
  port = local.port
  tags = ["external"]
  meta = {}

  check {
    check_id = "service:mongodb"
    name     = "MongoDB health check"
    status   = "passing"
    tcp      = "${local.url}:${local.port}"
    interval = "30s"
    timeout  = "3s"
  }
}

resource "consul_node" "database" {
  name    = "${var.business_unit}-database"
  address = local.url

  meta = {
    "external-node"  = "true"
    "external-probe" = "true"
  }
}

resource "consul_config_entry" "service_defaults" {
  name = "${var.business_unit}-database"
  kind = "service-defaults"

  config_json = jsonencode({
    Protocol         = "tcp"
    Expose           = {}
    MeshGateway      = {}
    TransparentProxy = {}
  })
}

data "consul_service_health" "database" {
  name    = consul_service.database.name
  passing = true
}