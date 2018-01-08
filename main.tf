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

resource "aws_subnet" "aws-vpn-subnet" {
  vpc_id  = "${aws_vpc.aws-vpn-vpc.id}"
  cidr_block = "${var.env["subnet_cidr"]}"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "aws-vpn-sg" {
  name          = "aws-vpn-sg"
  description   = "Group for VPN"
  vpc_id        = "${aws_vpc.aws-vpn-vpc.id}"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.env["full_cidr"]}"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.env["office_cidr"]}","${var.env["vpn_cidr"]}"]
  }
  tags {
    Name    = "aws-vpn-sg"
    Project = "${var.env["project_name"]}"
   }
 }

resource "aws_route_table" "aws-vpn-public-rt" {
  vpc_id  = "${aws_vpc.aws-vpn-vpc.id}"
  route {
    cidr_block = "${var.env["full_cidr"]}"
    gateway_id = "${aws_internet_gateway.aws-vpn-vpc-igw.id}"
  }
  tags {
    Name    = "aws-vpn-rt"
    Project = "${var.env["project_name"]}"
  }
}

resource "aws_route_table_association" "aws-vpn-public-rt-association" {
  subnet_id      = "${aws_subnet.aws-vpn-subnet.id}"
  route_table_id = "${aws_route_table.aws-vpn-public-rt.id}"
}

resource "aws_instance" "aws-vpn-ec2" {
  ami                     = "${var.env["ami_id"]}"
  instance_type           = "${var.env["instance_type"]}"
  vpc_security_group_ids  = ["${aws_security_group.aws-vpn-sg.id}"]
  subnet_id               = "${aws_subnet.aws-vpn-subnet.id}"
  key_name                = "${var.env["key_name"]}"
  tags {
    Name    = "aws-vpn-ec2"
    Project = "${var.env["project_name"]}"
  }
}

