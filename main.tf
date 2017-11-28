provider "aws" {
  region  = "${var.env["region"]}"
  shared_credentials_file = "${var.env["shared_credentials_file"]}"
  profile = "default"
}

resource "aws_vpc" "aws-vpn-vpc" {
  cidr_block           = "${var.env["vpc_cidr"]}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name    = "aws-vpn-vpc"
    Project = "${var.env["project_name"]}"
  }
}

resource "aws_internet_gateway" "aws-vpn-vpc-igw" {
  vpc_id = "${aws_vpc.aws-vpn-vpc.id}"

  tags {
    Name    = "aws-vpn-vps-igw"
    Project = "${var.env["project_name"]}"
  }
}