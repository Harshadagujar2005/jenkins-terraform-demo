variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type (t3.micro or t2.micro are free-tier eligible)"
  type        = string
  default     = "t3.micro"
}
