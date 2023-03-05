# provider "aws" {
#   region = var.region
# }

# resource "aws_eks_cluster" "this" {
#   name     = var.cluster_name
#   role_arn = aws_iam_role.eks.arn

#   vpc_config {
#     subnet_ids = aws_subnet.private.*.id
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.eks,
#     aws_iam_role_policy_attachment.eks_worker,
#   ]
# }

# resource "aws_iam_role" "eks" {
#   name = "${var.cluster_name}-eks"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.eks.name
# }

# resource "aws_iam_role_policy_attachment" "eks_worker" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.eks.name
# }

# resource "aws_iam_instance_profile" "eks_worker" {
#   name = "${var.cluster_name}-eks-worker"

#   role = aws_iam_role.eks.name
# }

# resource "aws_launch_configuration" "eks_worker" {
#   name_prefix   = "${var.cluster_name}-eks-worker"
#   image_id      = data.aws_ami.eks.id
#   instance_type = var.instance_type
#   iam_instance_profile = aws_iam_instance_profile.eks_worker.name
#   security_groups = [aws_security_group.worker.id]

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_security_group" "worker" {
#   name_prefix = "${var.cluster_name}-worker"
#   vpc_id      = data.aws_vpc.default.id

#   ingress {
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "tcp"
#     cidr_blocks = [data.aws_vpc.default.cidr_block]
#   }
# }

# resource "aws_iam_instance_profile" "eks_worker" {
#   name = "${var.cluster_name}