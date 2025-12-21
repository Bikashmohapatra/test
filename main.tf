
# # Create IAM user
# resource "aws_iam_user" "demo_user" {
#   count         = length(var.iam_username)
#   name          = var.iam_username[count.index]
#   force_destroy = true
# }

resource "aws_iam_user" "demo_user" {
  for_each = var.iam_username
  name     = each.value
}


# # Attach a managed policy (e.g., AdministratorAccess for demo)
# # 👉 In production, use least privilege instead!
# #resource "aws_iam_user_policy_attachment" "demo_attach" {
# #  user       = aws_iam_user.demo_user.name
# #  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# #}

# # Create login profile (password for console access)

# resource "aws_iam_access_key" "demo_key" {
#   user = aws_iam_user.demo_user.name
# }

# output "access_key_id" {
#   value = aws_iam_access_key.demo_key.id
# }

# output "secret_access_key" {
#   value     = aws_iam_access_key.demo_key.secret
#   sensitive = true
# }

# # Output username
# output "iam_username" {
#   value = aws_iam_user.demo_user.name
# }