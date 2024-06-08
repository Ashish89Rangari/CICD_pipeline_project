resource "aws_instance" "web" {
  ami                    = "ami-05e00961530ae1b55"      #change ami id for different region
  instance_type          = "t2.medium"
  key_name               = "Linux-VM-Key7"              #change key name as per your setup
  vpc_security_group_ids = [aws_security_group.Monitoring-Server-SG.id]
  user_data              = templatefile("./install.sh", {})

  tags = {
    Name = "Monitoring-Server"
  }

  root_block_device {
    volume_size = 20
  }
}

resource "aws_security_group" "Monitoring-Server-SG" {
  name        = "Monitoring-Server-SG"
  description = "Allow TLS inbound traffic"

  ingress = [
    for port in [22, 80, 443, 9090, 9100, 3000] : {    #port 9090- prometheus , 9100-node exporter, 3000-grafana
      description      = "inbound rules"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Monitoring-Server-SG"
  }
}