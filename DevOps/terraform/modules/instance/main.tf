# Create Security Group for Front-end
resource "aws_security_group" "frontend_sg" {
  name        = "${var.resource_prefix}_sg"
  description = "${var.resource_prefix} SG"
  vpc_id      = var.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = var.frontend_app_port
    to_port     = var.frontend_app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Create a launch configuration for application servers
resource "aws_launch_configuration" "this" {
  name                 = "${var.resource_prefix}-asg-lc"
  image_id             = var.instance_ami
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.frontend_sg.id]

  user_data = data.template_file.lc_user_data.rendered
}


# Create an Auto Scaling Group with launch configuration
resource "aws_autoscaling_group" "this" {
  name                 = "${var.resource_prefix}-asg"
  max_size             = var.instance_asg_max
  min_size             = var.instance_asg_min
  desired_capacity     = var.instance_asg_desired
  force_delete         = true
  launch_configuration = aws_launch_configuration.this.name
  target_group_arns    = [aws_alb_target_group.this.arn]
  vpc_zone_identifier  = var.subnet_id

  tag {
    key                 = "Name"
    value               = "${var.resource_prefix}-Server"
    propagate_at_launch = "true"
  }
  lifecycle {
    create_before_destroy = true
  }
}

//# Create Application Load Balancer for frontend server
resource "aws_lb" "frontend_alb" {
  name                       = "${var.resource_prefix}-alb"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.frontend_sg.id]
  enable_deletion_protection = false
  subnets                    = var.subnet_id

}


# Create Health check for ALB target
resource "aws_alb_target_group" "this" {
  name                 = "${var.resource_prefix}-target-group"
  port                 = var.frontend_app_port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = 60

  health_check {
    interval            = 5
    path                = var.hc_path
    protocol            = var.hc_protocol
    timeout             = 2
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-299,403"
  }
}

data "template_file" "lc_user_data" {
  template = file("${path.module}/user_data.sh")
}


resource "aws_lb_listener" "frontend_http" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = var.frontend_app_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}