output "instance_id" {
  value = "${aws_instance.test.id}"
  value = "${length(aws_instance.instance.*.id) > 0 ? element(concat(aws_instance.instance.*.id, list("")), 0) : ""}"
}
