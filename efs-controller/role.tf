resource "aws_iam_role" "efs-csi-role" {
  name = var.efs_role
  
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Federated": "${var.eks_issuer_arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${replace(var.eks_issuer_url, "https://", "")}:sub":[
            "system:serviceaccount:efs-driver:efs-csi-node-sa",
            "system:serviceaccount:efs-driver:efs-csi-controller-sa"
          ]
        }
      }
    }
  ]
}
POLICY

  tags = {
    "ServiceAccountName"      = var.efs_serviceaccount
    "ServiceAccountNameSpace" = var.efs_controller_namespace
  }
}


resource "aws_iam_role_policy_attachment" "efs-csi-iam-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
  role       = aws_iam_role.efs-csi-role.name
  depends_on = [aws_iam_role.efs-csi-role]
}