output "my_vpc_no" {
  value = ncloud_vpc.my_vpc.id
}

data "ncloud_server_images" "images" {
  output_file = "image.json"
}

output "my_key" {
  sensitive = true
  value = ncloud_login_key.my_key.private_key
}

output "my_server_public_ip" {
  value = ncloud_public_ip.my_public_ip.public_ip
}
