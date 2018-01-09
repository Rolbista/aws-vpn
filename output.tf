resource "template_file" "ssh_config" {
  template = "${file("templates/ssh_config.tpl")}"
  vars {
    host_ip = "${aws_instance.aws-vpn-ec2.public_ip}"
    host_dns = "${aws_instance.aws-vpn-ec2.public_dns}"
  }
}

output "ssh_config" {
  value = "${template_file.ssh_config.rendered}"
}

# output "aws-vpn-public-ip" {
#   value = "${aws_instance.aws-vpn-ec2.public_ip}"
# }
