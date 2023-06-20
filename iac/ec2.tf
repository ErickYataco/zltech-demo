

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}

resource "aws_instance" "challenge" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t3a.micro"
  key_name      = "your_key_name" # put your name key here

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
  }

  tags = {
    Name = "challenge-instance"
  }
}



