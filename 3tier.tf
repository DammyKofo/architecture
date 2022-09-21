resource "aws_vpc" "dammy-vpc" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "dammy-vpc"
  }
}

resource "aws_internet_gateway" "test-igw" {
  vpc_id = aws_vpc.dammy-vpc.id

  tags = {
    Name = "test-igw"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.dammy-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.dammy-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_route_table" "dammy-public-rt" {
  vpc_id = aws_vpc.dammy-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-igw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id             = aws_internet_gateway.test-igw.id
  }

  tags = {
    Name = "dammy-public-rt"
  }
}

resource "aws_route_table_association" "public-subnet-1-rt-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.dammy-public-rt.id
}

resource "aws_route_table_association" "public-subnet-2-rt-association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.dammy-public-rt.id
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.dammy-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet-1 App Tier"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.dammy-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-2 | App Tier"
  }
}

resource "aws_subnet" "private-subnet-3" {
  vpc_id     = aws_vpc.dammy-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet-3 | Database Tier"
  }
}

resource "aws_subnet" "private-subnet-4" {
  vpc_id     = aws_vpc.dammy-vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-4 | Database Tier"
  }
}