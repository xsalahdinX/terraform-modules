resource "aws_vpc_endpoint" "s3" {
  vpc_id            = data.aws_vpc.eks-vpc.id
  service_name      = "com.amazonaws.${var.region}.s3"
  route_table_ids   = [data.aws_route_table.private-aws_route_table.id]
  vpc_endpoint_type = "Gateway"
  policy            = data.aws_iam_policy_document.s3_endpoint_policy.json
  tags              = { Name = "app-vpce-s3" }

}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = ["private_subnets_*"]
  }

}

data "aws_route_table" "private-aws_route_table" {
  subnet_id = data.aws_subnets.private_subnets.ids[0]
}


data "aws_vpc" "eks-vpc" {
  filter {
    name   = "tag:Name"
    values = ["EKS_VPC"]
  }

}

data "aws_iam_policy_document" "s3_endpoint_policy" {
  # dynamic "statement" {
  #   for_each = var.resource_principal_map

  #   content {
  #     sid    = "AllowActionsTo${join("-", slice(split("-", statement.key), 1, 3))}Roll"
  #     effect = "Allow"

  #     actions = [
  #       "s3:PutObject",
  #       "s3:GetObject",
  #       "s3:ListBucketMultipartUploads",
  #       "s3:ListBucketVersions",
  #       "s3:ListBucket",
  #       "s3:ListMultipartUploadParts"
  #     ]
  #     resources = ["arn:aws:s3:::${statement.key}" , "arn:aws:s3:::${statement.key}/*"]
  #     principals {
  #       type        = "AWS"
  #       identifiers = ["*"]
  #     }
  #     condition {
  #       test     = "ArnEquals"
  #       variable = "aws:PrincipalArn"
  #       values   = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${statement.value}"]
  #     }
  #   }
  # }
  
statement {
    sid    = "AllowGetObject"
    effect = "Allow"

    actions = [ "s3:GetObject", "s3:ListBucket"]

    resources = flatten([
      for bucket_name in var.bucket_name : [
        "arn:aws:s3:::${bucket_name}",
        "arn:aws:s3:::${bucket_name}/*"
      ]
    ])
  
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

  }
}
    # condition {
    #   test     = "ArnEquals"
    #   variable = "aws:PrincipalArn"
    #   values   = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.s3_addon_iam_role_name}"]
    # }