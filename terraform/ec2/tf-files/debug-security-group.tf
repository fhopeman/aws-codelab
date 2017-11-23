// 2. Deploy debug security group
//resource "aws_security_group" "debugsecuritygroup" {
//  name = "Allow SSH Traffic"
//  vpc_id = "${aws_vpc.vpc.id}"
//
//  ingress {
//    from_port = 22
//    protocol = "tcp"
//    to_port = 22
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//}