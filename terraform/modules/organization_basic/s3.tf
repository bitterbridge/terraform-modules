resource "aws_s3_bucket" "terraform_state" {
  bucket        = "${var.organization_name}.terraform"
  force_destroy = false // Don't zap this! It's our state storage.
}
