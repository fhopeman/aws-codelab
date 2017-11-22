resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpcCidr}"
  tags {
    Name = "${var.TeamName}-vpc"
  }
}

resource "aws_subnet" "publicsubnets" {
  count = "${length(var.availabilityZones)}"
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 5, count.index)}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${element(var.availabilityZones, count.index)}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "routetable" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route" "routepublic" {
  depends_on = ["aws_internet_gateway.igw"]
  route_table_id = "${aws_route_table.routetable.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}

resource "aws_route_table_association" "subnettopublic" {
  count = "${length(var.availabilityZones)}"
  route_table_id = "${aws_route_table.routetable.id}"
  subnet_id = "${element(aws_subnet.publicsubnets.*.id,count.index)}"
}
