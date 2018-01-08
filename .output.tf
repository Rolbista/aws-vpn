resource "template_file" "ssh_config" {
  template = "${file("templates/ssh_config.tpl")}"
  vars {
    jmp_ip = "${aws_instance.pr_jumphost.public_ip}"
  }
}

output "ssh_config" {
  value = "${template_file.ssh_config.rendered}"
}

output "jumphost_public_ip" {
  value = "${aws_instance.pr_jumphost.public_ip}"
}
