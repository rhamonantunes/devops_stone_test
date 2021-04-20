#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "stone" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = tomap({
    "Name" = "tf-node-iam-role"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  })
}

resource "aws_subnet" "stone" {
  count = 3

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.stone.id

  tags = tomap({
    "Name" = "tf-node-iam-role"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  })
}

resource "aws_internet_gateway" "stone" {
  vpc_id = aws_vpc.stone.id

  tags = {
    Name = "terraform-eks-stone"
  }
}

resource "aws_route_table" "stone" {
  vpc_id = aws_vpc.stone.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.stone.id
  }
}

resource "aws_route_table_association" "stone" {
  count = 3

  subnet_id      = aws_subnet.stone.*.id[count.index]
  route_table_id = aws_route_table.stone.id
}