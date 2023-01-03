resource "aws_instance" "public" {
    ami                         = "ami-0b5eea76982371e91"
    associate_public_ip_address = true
    instance_type               = "t3.micro"
    key_name                    = "myMac"
    vpc_security_group_ids      = [aws_security_group.public.id]
    subnet_id                   = aws_subnet.public[0].id
    
    tags = {
        Name = "${var.environment_tag}-public"
    }
}

resource "aws_security_group" "public" {
    name        = "${var.environment_tag}-public"
    description = "Allow TLS inbound traffic"
    vpc_id      = aws_vpc.main.id

    ingress {
        description      = "SSH from public"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["73.201.13.253/32"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.environment_tag}-public"
    }
}


resource "aws_instance" "private" {
    ami                         = "ami-0b5eea76982371e91"
    instance_type               = "t3.micro"
    key_name                    = "myMac"
    vpc_security_group_ids      = [aws_security_group.private.id]
    subnet_id                   = aws_subnet.private[0].id
    
    tags = {
        Name = "${var.environment_tag}-private"
    }
}

resource "aws_security_group" "private" {
    name        = "${var.environment_tag}-private"
    description = "Allow VPC traffic"
    vpc_id      = aws_vpc.main.id

    ingress {
        description      = "SSH from VPC"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = [var.vpc_cidr]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.environment_tag}-private"
    }
}