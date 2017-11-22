resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
  tags {
    Name = "${var.team_name}-vpc"
  }
}

resource "aws_subnet" "publicsubnets" {
  count = "${length(data.aws_availability_zones.current.names)}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 5, count.index)}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${element(data.aws_availability_zones.current.names, count.index)}"

  tags {
    Name = "${var.team_name}-${element(data.aws_availability_zones.current.names, count.index)}-sn"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.team_name}-ig"
  }
}

resource "aws_route_table" "routetable" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.team_name}-rt"
  }
}

resource "aws_route" "routepublic" {
  depends_on = [
    "aws_internet_gateway.igw"
  ]
  route_table_id = "${aws_route_table.routetable.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}

resource "aws_route_table_association" "subnettopublic" {
  count = "${length(data.aws_availability_zones.current.names)}"
  route_table_id = "${aws_route_table.routetable.id}"
  subnet_id = "${element(aws_subnet.publicsubnets.*.id, count.index)}"
}
