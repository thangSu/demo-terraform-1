resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = var.name_vpc
  }
}
resource "aws_internet_gateway" "ig1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    "Name" = "Thang gateway"
  }
}
resource "aws_subnet" "subnet" {
    count = length(var.subnet_list)
    vpc_id = aws_vpc.vpc1.id
    availability_zone = var.zone_list[count.index]
    cidr_block = var.subnet_list[count.index]
    tags = {
        "Name" = "Thang subnet ${count.index}"
    }
}
resource "aws_route_table" "rt1" {
    vpc_id = aws_vpc.vpc1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig1.id
    }
    route {
        ipv6_cidr_block  = "::/0"
        gateway_id = aws_internet_gateway.ig1.id
    }
    tags = {
      "Name" = "thang rt"
    }
}
resource "aws_route_table_association" "rta" {
  route_table_id = aws_route_table.rt1.id
  subnet_id = aws_subnet.subnet[0].id
}


