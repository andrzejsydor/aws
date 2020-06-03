# resource "aws_iam_role" "ec2_admin_role" {
#   name = var.ec2_admin_role_name
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Resource": "*",
#       "Action": "*"
#     }
#   ]
# }
# EOF
# }


# # data "aws_iam_policy_document" "ec2_admin_role" {
# #   version = "2012-10-17"
# #   statement {
# #     sid = ""
# #     effect = "Allow"

# #     actions = ["*"]
# #     resources = ["*"]
# #   }
# # }

# # resource "aws_iam_role" "ec2_admin_role" {
# #   name               = var.ec2_admin_role_name
# #   assume_role_policy = data.aws_iam_policy_document.ec2_admin_role.json
# # }
