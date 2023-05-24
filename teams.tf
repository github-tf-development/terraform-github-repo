# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "github_team" "all" {
  for_each = {
    for team in csvdecode(file("teams.csv")) :
    team.name => team
  }
  name                      = each.value.name
  description               = each.value.description
  privacy                   = each.value.privacy
  create_default_maintainer = true
}

resource "null_resource" "wait" {
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "sleep 400"
  }
}

resource "github_team_membership" "members" {
  depends_on =[github_team.all]
  for_each = { for tm in local.team_members : tm.name => tm }

  team_id  = each.value.team_id
  username = each.value.username
  role     = each.value.role
}
