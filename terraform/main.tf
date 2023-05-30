resource "ncloud_vpc" "my_vpc" {
  ipv4_cidr_block = "10.0.0.0/16"
  name = "my-vpc"
}

resource "ncloud_network_acl" "my_nacl" {
  vpc_no = ncloud_vpc.my_vpc.id
  name = "my-nacl"
}

resource "ncloud_subnet" "my_public_subnet_01" {
  vpc_no         = ncloud_vpc.my_vpc.id
  subnet         = "10.0.1.0/24"
  zone           = "KR-1"
  network_acl_no = ncloud_network_acl.my_nacl.id
  subnet_type    = "PUBLIC"
  name           = "subnet-kr1-01"
  usage_type     = "GEN"
}

resource "ncloud_subnet" "my_private_subnet_01" {
  vpc_no         = ncloud_vpc.my_vpc.id
  subnet         = "10.0.2.0/24"
  zone           = "KR-1"
  network_acl_no = ncloud_network_acl.my_nacl.id
  subnet_type    = "PRIVATE"
  name           = "subnet-kr1-02"
  usage_type     = "GEN"
}

resource "ncloud_subnet" "my_public_subnet_02" {
  vpc_no         = ncloud_vpc.my_vpc.id
  subnet         = "10.0.65.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.my_nacl.id
  subnet_type    = "PUBLIC"
  name           = "subnet-kr2-01"
  usage_type     = "GEN"
}

resource "ncloud_subnet" "my_private_subnet_02" {
  vpc_no         = ncloud_vpc.my_vpc.id
  subnet         = "10.0.66.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.my_nacl.id
  subnet_type    = "PRIVATE"
  name           = "subnet-kr2-02"
  usage_type     = "GEN"
}

resource "ncloud_login_key" "my_key" {
  key_name = "my-key"
}

resource "ncloud_init_script" "my_init" {
  name    = "set-root-password"
  // multiline bash init script
  content = <<-EOF
    #!/usr/bin/env bash

    echo "root:${var.server_password}" | chpasswd
    EOF
}

resource "ncloud_server" "my_server" {
  subnet_no                 = ncloud_subnet.my_public_subnet_01.id
  name                      = "my-public-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.ROCKY.0806.B050" // rocky 8
  login_key_name            = ncloud_login_key.my_key.key_name
  init_script_no            = ncloud_init_script.my_init.id
}

resource "ncloud_public_ip" "my_public_ip" {
  server_instance_no = ncloud_server.my_server.id
}
