
cidr_block = "10.0.0.0/16"

instance_tenancy = "default"

dns = "true"

tags = {
    "Name" = "EKS"
    "terraform" = "true"
}

public-cidr-1 = "10.0.1.0/24"

public-ip = true

public1-azs = "ap-south-1a"

public-cidr-2 = "10.0.2.0/24"

public2-azs = "ap-south-1b"

route = "0.0.0.0/0"

from_port = "22"

to_port = "22"