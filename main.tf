# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "github" {
  token = var.GITHUB_ORG_TOKEN
}

# Retrieve information about the currently (PAT) authenticated user
data "github_user" "self" {
  username = ""
}
