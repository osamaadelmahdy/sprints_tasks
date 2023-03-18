resource "aws_ecr_repository" "my_repo" {
  name                 = "my-flask-repo"
  image_tag_mutability = "MUTABLE"
  tags = {
    Terraform = "true"
  }
}
