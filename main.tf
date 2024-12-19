resource "aws_launch_template" "template" {
name = "terraform-template"
image_id = "ami-0166fe664262f664c"
instance_type = "t2.micro"
key_name = "vpc"
vpc_security_group_ids = [aws_security_group.sg.id]
}



resource "aws_autoscaling_group" "asg" {
name = "terraform-asg"
launch_template {
id = aws_launch_template.template.id
}
min_size = 1
max_size = 4
desired_capacity = 3
health_check_type = "EC2"
availability_zones = ["us-east-1a", "us-east-1b"]
load_balancers = [aws_elb.elb.id]
}

resource "aws_elb" "elb" {
name = "terraform-lb"
subnets = ["subnet-0b450da917751177c", "subnet-0bf18960579be24b2"]
security_groups = [aws_security_group.sg.id]
listener {
instance_port = 80
instance_protocol = "HTTP"
lb_port = 80
lb_protocol = "HTTP"
}
}


