data "aws_iam_policy_document" "ec2_assume_role" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

# -- IAM Role for EC2
resource "aws_iam_role" "ec2" {
    name = "qwik-api-server-role"
    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

    tags = {
        Name = "qwik-api-server-role"
    }
}

resource "aws_iam_role_policy_attachment" "ec2_ssm" {
    role       = aws_iam_role.ec2.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ecr" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "ec2" {
    name = "qwik-api-server-instance-profile"
    role = aws_iam_role.ec2.name
}