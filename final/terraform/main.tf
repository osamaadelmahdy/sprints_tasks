provider "aws" {
  region = "us-east-1"
}

# Create an EKS cluster
resource "aws_eks_cluster" "example" {
  name     = "example-cluster"
  role_arn = aws_iam_role.eks.arn

# Create an EKS cluster
resource "aws_eks_cluster" "example" {
  name     = "example-cluster"
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    subnet_ids = aws_subnet.private.*.id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks,
  ]
}

# Create an IAM role for EKS
resource "aws_iam_role" "eks" {
  name = "eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

# Attach a policy to the EKS role
resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

# Create a VPC for the EKS cluster
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "example-vpc"
  }
}
# Create private subnets for the EKS cluster
resource "aws_subnet" "private" {
  count = 3

  cidr_block = "10.0.${count.index + 1}.0/24"
  vpc_id     = aws_vpc.example.id

  tags = {
    Name = "example-private-subnet-${count.index + 1}"
  }
}

# Create an Internet Gateway for the EKS cluster
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "example-igw"
  }
}
# Create a NAT Gateway for the EKS cluster
resource "aws_nat_gateway" "example" {
  count = 3

  allocation_id = aws_eip.example[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "example-nat-gateway-${count.index + 1}"
  }
}
