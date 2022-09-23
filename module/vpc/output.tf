output "subnet_id" {
  value =[aws_subnet.subnet[0].id,aws_subnet.subnet[1].id,aws_subnet.subnet[2].id]
}
output "vpc_id" {
  value = aws_vpc.vpc1.id
}