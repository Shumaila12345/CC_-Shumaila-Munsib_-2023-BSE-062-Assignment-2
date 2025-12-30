variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "AWS availability zone"
  type        = string
}

variable "env_prefix" {
  description = "Environment name prefix"
  type        = string
  default     = "prod"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "public_key" {
  description = "Path to SSH public key"
  type        = string
}

variable "private_key" {
  description = "Path to SSH private key"
  type        = string
}

variable "backend_servers" {
  description = "Backend server configuration"
  type = list(object({
    name        = string
    script_path = string
  }))
}
