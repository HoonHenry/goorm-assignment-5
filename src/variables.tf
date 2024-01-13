# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "k8s_version" {
  description = "k8s version"
  type        = string
  default     = "1.28"
}

variable "ebs_csi_addon_version" {
  description = "ebs csi addon version"
  type        = string
  default     = "v1.20.0-eksbuild.1"
}
