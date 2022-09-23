# create vpc
module "thang_vpc" {
    source = "./module/vpc"
    name_vpc = "thang vpc"
    vpc_cidr = "10.1.0.0/16"
    subnet_list = ["10.1.1.0/24","10.1.2.0/24","10.1.3.0/24"]
}
# create sg 
resource "aws_security_group" "ec2_sg" {
    name = "thang test"
    vpc_id = module.thang_vpc.vpc_id
    #inbound
    ingress {
         description = "allow HTTP protocol"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        description = "allow HTTPs protocol"
        from_port = 433
        to_port = 433
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    #outbound
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    tags = {
      "Name" = "ansible_sg"
    }
}

module "thang_instance" {
    count = length(var.name_instance)
    source = "./module/instance"
    security_list=[aws_security_group.ec2_sg.id]
    subnet= module.thang_vpc.subnet_id[0]
    key_pair = "thangpham"
    name_ec2 = "${var.name_instance[count.index]}"
}

