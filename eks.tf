
# EKS Cluster Creation with master and worker Nodes

resource "aws_iam_role" "master" {
    name = "ed-eks-master"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role       = aws_iam_role.master.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
    role       = aws_iam_role.master.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
    role       = aws_iam_role.master.name
}

resource "aws_iam_role" "worker" {
    name = "ed-eks-worker"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
    ]
}
POLICY
}

resource "aws_iam_policy" "autoscaler" {
    name   = "ed-eks-autoscaler-policy"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": [
            "autoscaling:DescribeAutoScalingGroups",
            "autoscaling:DescribeAutoScalingInstances",
            "autoscaling:DescribeTags",
            "autoscaling:DescribeLaunchConfigurations",
            "autoscaling:SetDesiredCapacity",
            "autoscaling:TerminateInstanceInAutoScalingGroup",
            "ec2:DescribeLaunchTemplateVersions"
        ],
        "Effect": "Allow",
        "Resource": "*"
    }
    ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.worker.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.worker.name
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    role       = aws_iam_role.worker.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.worker.name
}

resource "aws_iam_role_policy_attachment" "x-ray" {
    policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
    role       = aws_iam_role.worker.name
}
resource "aws_iam_role_policy_attachment" "s3" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    role       = aws_iam_role.worker.name
}

resource "aws_iam_role_policy_attachment" "autoscaler" {
    policy_arn = aws_iam_policy.autoscaler.arn
    role       = aws_iam_role.worker.name
}

resource "aws_iam_instance_profile" "worker" {
    depends_on = [aws_iam_role.worker]
    name       = "ed-eks-worker-new-profile"
    role       = aws_iam_role.worker.name
}

###############################################################################################################
resource "aws_eks_cluster" "EKS-Cluster" {
    name = "EKS-Cluster"
    role_arn = aws_iam_role.master.arn

    vpc_config {
        subnet_ids = [aws_subnet.public-1.id, aws_subnet.public-2.id]
    }
    
    depends_on = [
        aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
        aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
        aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
        aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
        #aws_subnet.pub_sub1,
        #aws_subnet.pub_sub2,
    ]

}
#################################################################################################################

resource "aws_eks_node_group" "Node-Group" {
    cluster_name    = aws_eks_cluster.EKS-Cluster.name
    node_group_name = "Node-Group"
    node_role_arn   = aws_iam_role.worker.arn
    subnet_ids = [aws_subnet.public-1.id, aws_subnet.public-2.id]
    capacity_type = "ON_DEMAND"
    disk_size = "20"
    instance_types = ["t2.medium"]
    remote_access {
        ec2_ssh_key = "Minikube_Ravi"
        source_security_group_ids = [aws_security_group.Eks-Sg.id]
    } 

    labels =  tomap({env = "dev"})

    scaling_config {
        desired_size = 2
        max_size     = 3
        min_size     = 1
    }

    update_config {
        max_unavailable = 1
    }

    depends_on = [
        aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
        #aws_subnet.pub_sub1,
        #aws_subnet.pub_sub2,
    ]
}

# Creating an Instance as Kubectl server.
resource "aws_instance" "kubectl-server" {
    ami                         = "ami-0287a05f0ef0e9d9a"
    key_name                    = "Minikube_Ravi"
    instance_type               = "t2.micro"
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.public-1.id
    vpc_security_group_ids      = [aws_security_group.Eks-Sg.id]

    tags = {
        Name = "kubectl"
    }

}