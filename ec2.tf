data "aws_ami" "amazon_linux" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name = "name"
        values = ["al2023-ami-*-x86_64"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

# -- ec2
resource "aws_instance" "api" {
    ami           = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    subnet_id = module.network.private_subnet_ids[0]
    vpc_security_group_ids = [aws_security_group.ec2.id]
    iam_instance_profile = aws_iam_instance_profile.ec2.name

    user_data = <<-E0F
        #!/bin/bash
        dnf update -y
        dnf install -y docker
        systemctl start docker
        systemctl enable docker
    E0F

    tags = {
        Name = "qwik-api-server"
    }
}