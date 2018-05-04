# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2016, 2018 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

##############################################################
# Script to install Dynatrace OneAgent
##############################################################


resource "camc_scriptpackage" "RemoteScript" {
  program = ["/bin/bash", "/tmp/install_dynatrace_oneagent_linux.sh", "${var.dynatrace_env_id}", "${var.dynatrace_api_token}", "${var.dynatrace_logs}", "> /tmp/install_dynatrace_oneagent_linux.log"]
  remote_host = "${var.ip_address}"
  remote_user = "${var.user}"
  remote_password = "${var.password}"
  remote_key = "${var.private_key}"
  destination = "/tmp/install_dynatrace_oneagent_linux.sh"
  source = "${path.module}/scripts/install_dynatrace_oneagent_linux.sh"
  on_create = true
}
