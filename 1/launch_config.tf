resource "aws_launch_configuration" "worker" {
  name_prefix = "testing-"

  image_id                    = "${data.aws_ami.amazon_linux.id}"
  instance_type               = "${var.worker_instance_type}"
  security_groups             = ["${aws_security_group.worker.id}"]

  user_data = "${data.template_cloudinit_config.user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "bastion" {
  vpc = true
}