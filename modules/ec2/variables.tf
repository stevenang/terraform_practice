variable "instance_name" {
    type = string
}

variable "ami" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "cpu_core_count" {
    type = number
    default = 2
}

variable "cpu_threads_per_core" {
    type = number
    default = 2
}

variable "user_data" {
    type = string
}