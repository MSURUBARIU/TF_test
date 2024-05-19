locals {
  # I needed to add this in order to make the public_access_block use a for each, 
  # and have shorter variables, so the code is more readable.
  example_instance_name = {
    name = "${var.common_tags.environment}-${var.aws_region}-${var.example_instance.name}"
  }

}