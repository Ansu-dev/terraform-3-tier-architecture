variable "source_instance_id" {
  description = "The ID of the source instance to create the AMI from"
  type        = string
}

variable "instance_type" {
  description = "The instance type form the launch template"
  type        = string
}

variable "key_name" {
  description = "The key pair name for the launch template"
  type        = string
}