variable "security_list" {
  type =list
}
variable "subnet" {
  type = string
}
variable "type_iam" {
  type = string
  default = "t2.micro"
}
variable "key_pair" {
  type = string
}
variable "name_ec2" {
  type = string
}