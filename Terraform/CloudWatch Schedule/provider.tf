provider "aws" {
  profile                 = "default"
  version                 = "~> 3.0"
  region                  = var.aws_region
}
