data "aws_ami" "test_ami" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

#
# Type: asg
#
resource "aws_launch_template" "template" {
  count         = "${var.type == "asg" ? 1 : 0}"
  image_id      = "${data.aws_ami.test_ami.id}"
  instance_type = "t2.micro"
}

data "aws_availability_zones" "available" {}

resource "aws_autoscaling_group" "asg" {
  count              = "${var.type == "asg" ? 1 : 0}"
  availability_zones = ["${data.aws_availability_zones.available.names[0]}"]

  launch_template {
    id      = "${aws_launch_template.template.id}"
    version = "${aws_launch_template.template.latest_version}"
  }

  desired_capacity = 1
  max_size         = 1
  min_size         = 1
}

#
# Type: instance
#

resource "aws_instance" "instance" {
  count             = "${var.type == "instance" ? 1 : 0}"
  ami               = "${data.aws_ami.test_ami.id}"
  instance_type     = "t2.micro"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    CostCenter = "OPS"
  }
}
