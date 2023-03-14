provider "aws" {
  region = "us-west-2" # replace with your desired region
}

resource "aws_vpc" "eks" {
  cidr_block = "10.0.0.0/16" # replace with your desired CIDR block

  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_subnet" "eks_private" {
  count = 2 # replace with your desired number of private subnets

  cidr_block = "10.0.${count.index}.0/24" # replace with your desired CIDR block
  vpc_id     = aws_vpc.eks.id

  tags = {
    Name = "eks-private-${count.index}"
  }
}

resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role" "eks_node_group" {
  name = "eks-node-group"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_group_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group.name
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name = "my-eks-cluster"            # replace with your desired cluster name
  subnets      = aws_subnet.eks_private.*.id # use private subnets for worker nodes
  vpc_id       = aws_vpc.eks.id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  tags_all = {
    Terraform   = "true"
    Environment = "dev"
  }

  // configure the IAM roles for the EKS cluster
  kubelet_extra_args = {
    "node-labels"          = "role=worker"
    "register-with-taints" = "dedicated=worker:NoSchedule"
  }

  // use the IAM roles defined above
  create_eks_cluster = true
  eks_cluster_iam_roles = [
    aws_iam_role.eks_cluster.arn,
    aws_iam_role.eks_node_group.arn,
  ]
}
