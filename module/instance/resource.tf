data "aws_ami""ami_linux" {

	most_recent = true
    owners = ["amazon"]
	filter {
	name = "name"
	values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
	}
	filter {
	name = "virtualization-type"
	values = ["hvm"]
  }
}
resource "aws_instance" "instance" {
  ami = data.aws_ami.ami_linux.id
  instance_type = var.type_iam
  subnet_id = var.subnet
  vpc_security_group_ids = var.security_list
  key_name = var.key_pair
  associate_public_ip_address = true
  tags = {
    "Name" ="${var.name_ec2}"
  }
  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install httpd -y
                sudo service httpd start
                sudo bash -c  "echo '<center><h1>I did it successfully ${var.name_ec2}</h1></center>' > /var/www/html/index.html"
                EOF
}
