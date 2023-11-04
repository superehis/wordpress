resource "aws_iam_user_login_profile" "DB_user" {
  count                   = length(var.username)
  user                    = aws_iam_user.eks_user[count.index].name
  password_reset_required = true
  pgp_key                 = "keybase:blanche"
}

resource "aws_iam_user" "eks_user" {
  count         = length(var.username)
  name          = element(var.username, count.index)
  force_destroy = true

  tags = {
    Department = "eks_user"
  }
}

# EKS Devoloper's group and attached policy
resource "aws_iam_group" "eks_developer" {
  name = "webdev"
}

resource "aws_iam_group_policy" "developer_policy" {
  name   = "webdev"
  group  = aws_iam_group.eks_developer.name
  policy = data.aws_iam_policy_document.developer.json
}

resource "aws_iam_group_membership" "db_team" {
  name  = "dev-group-membership"
  users = [aws_iam_user.eks_user[0].name]
  group = aws_iam_group.eks_developer.name
}
 #EKS admin's group
resource "aws_iam_group" "eks_masters" {
  name = "Masters"
}

resource "aws_iam_group_policy" "masters_policy" {
  name   = "Masters"
  group  = aws_iam_group.eks_masters.name
  policy = data.aws_iam_policy_document.masters_role.json
}

resource "aws_iam_group_membership" "masters_team" {
  name  = "masters-group-membership"
  users = [aws_iam_user.eks_user[0].name, aws_iam_user.eks_user[1
  ].name]
  group = aws_iam_group.eks_masters.name
}


resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}

# Admin role to be assumed only by manager
resource "aws_iam_role" "masters" {
  name               = "Masters-eks-Role"
  assume_role_policy = data.aws_iam_policy_document.masters_assume_role.json
}

resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.masters.name
  policy_arn = aws_iam_policy.eks_admin.arn
}

resource "aws_iam_policy" "eks_admin" {
  name   = "eks_masters"
  policy = data.aws_iam_policy_document.masters.json
}

data "aws_iam_policy_document" "masters" {
  // ...
}
