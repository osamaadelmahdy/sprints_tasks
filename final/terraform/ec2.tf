# resource "aws_instance" "jenkins" {
#   ami           = var.aws_ami
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   subnet_id     = aws_subnet.private_subnet.id

#   tags = {
#     Name = "jenkins"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get update",
#       "sudo apt-get install -y default-jdk",
#       "sudo apt-get install -y git",
#       "sudo apt-get install -y docker.io",
#       "sudo usermod -aG docker ubuntu"
#     ]
#   }

#   connection {
#     type        = "ssh"
#     user        = "ubuntu"
#     private_key = file(var.private_key_path)
#     host        = self.public_ip
#   }
# }