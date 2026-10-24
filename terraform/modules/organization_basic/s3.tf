resource "aws_s3_bucket" "terraform_state" {
  bucket        = coalesce(var.state_bucket_name, "${var.organization_name}.terraform")
  force_destroy = false // Don't zap this! It's our state storage.
}
