resource "helm_release" "aws_auth" {
  name       = "aws-auth"
  chart      = "github.com/xsalahdinX/terraform-modules//charts/aws-auth"
  depends_on = [ kubernetes_annotations.aws_auth_annotations ]
  
  
  set {
    name   = "accountId"
    value = "${var.account_id}"
  }
  set_list {
    name   = "nodegroup_role"
    value = var.nodegroup_role
  }
    set_list {
    name   = "iam_admin_roles"
    value = var.iam_admin_roles
  }
}
