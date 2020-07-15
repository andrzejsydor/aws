resource "aws_dynamodb_table" "guids-dynamodb-table" {
  name           = "guids"
  billing_mode   = "PROVISIONED"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "guid"
  range_key      = "region"

  attribute {
    name = "guid"
    type = "S"
  }

  attribute {
    name = "region"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  global_secondary_index {
    name               = "RegionIndex"
    hash_key           = "region"
    range_key          = "TopScore"
    write_capacity     = 2
    read_capacity      = 2
    projection_type    = "INCLUDE"
    non_key_attributes = ["guid"]
  }

  tags = {
    Project        = var.TAG-Project
    Environment    = var.TAG-Environment
  }
}
