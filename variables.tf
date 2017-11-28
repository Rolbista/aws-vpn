variable "env" {
  default = {
    shared_credentials_file = "/Users/wojciechg/.aws/credentials"
    region           = "us-east-2"
    vpc_cidr         = "10.0.0.0/16"
    full_cidr        = "0.0.0.0/0"
    office_cidr      = "91.222.71.98/32"
    vpn_cidr         = "195.89.171.5/32"
    project_name     = "aws-vpn"
    ami_id           = "ami-cfdafaaa"
    instance_type    = "t2.micro"
    key_name         = "pr_keys"
  }
}