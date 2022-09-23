output "ec2_ip" {
  value = aws_instance.instance.public_ip
}
output "ec2_ippr" {
  value = aws_instance.instance.private_ip
}
output "ec2_id" {
  value = aws_instance.instance.id
}