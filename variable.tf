
variable "cidr_block" {
    type = string
}

variable "instance_tenancy" {
    type = string
}

variable "dns" {
    type = bool
}

variable "tags" {
    type = map(string)
    default = { }
}

variable "public-cidr-1" {
    type = string
}

variable "public-ip" {
    type = bool
}

variable "public1-azs" {
    type = string
}

variable "public-cidr-2" {
    type = string
}

variable "from_port" {
    type = number
}

variable "to_port" {
    type = number
}

variable "public2-azs" {
    type = string
}

variable "route" {
    type = string
}