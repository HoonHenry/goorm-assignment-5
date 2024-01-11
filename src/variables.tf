# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

# variable "json_input" {
#   description = "iam policy input file to create iam policy for eks"
#   type        = string
#   default     = "./manifests/alb-ingress-controller/iam_policy.json"
# }

# variable "ing_full_yaml" {
#   description = "yaml file to create ingress controller"
#   type        = string
#   default     = "./manifests/alb-ingress-controller/v2_5_4_full.yaml"
# }

# variable "ing_class_yaml" {
#   description = "yaml file to create ing class"
#   type        = string
#   default     = "./manifests/alb-ingress-controller/v2_5_4_ingclass.yaml"
# }
