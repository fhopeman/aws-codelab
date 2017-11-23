// 3. Deploy yocto
//resource "aws_security_group" "instance" {
//  name = "Allow access via http"
//  vpc_id = "${aws_vpc.vpc.id}"
//
//  ingress {
//    from_port = 8080
//    protocol = "tcp"
//    to_port = 8080
//    cidr_blocks = [
//      "0.0.0.0/0"]
//  }
//
//  egress {
//    from_port = 0
//    protocol = "-1"
//    to_port = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  tags {
//    Name = "${var.team_name}-yocto-instance-sg"
//  }
//}
//
//data "template_file" "userdata" {
//  template = "${file("${path.module}/userdata.tpl")}"
//}
//
//resource "aws_launch_configuration" "yoctolaunch" {
//  name_prefix = "${var.team_name}-"
//  image_id = "${var.ami_id}"
//  instance_type = "${var.instance_type}"
//  key_name = "${var.sshkeyname}"
//  user_data = "${data.template_file.userdata.rendered}"
//  security_groups = ["${aws_security_group.instance.id}"]
//  associate_public_ip_address = true
//  lifecycle { create_before_destroy = true }
//}
//
//resource "aws_autoscaling_group" "yoctoautoscaling" {
//  name_prefix = "${var.team_name}-"
//  launch_configuration = "${aws_launch_configuration.yoctolaunch.id}"
//  max_size = 2
//  min_size = 1
//  desired_capacity = 1
//  vpc_zone_identifier = ["${aws_subnet.publicsubnets.*.id}"]
//  health_check_type = "ELB"
//  health_check_grace_period = 120
//  wait_for_capacity_timeout = "3m"
//
//  lifecycle {create_before_destroy = true}
//
//  tags = [
//    {
//      key = "Name"
//      value = "${var.team_name}-yocto"
//      propagate_at_launch = true
//    }
//  ]
//}