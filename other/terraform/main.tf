module "dynatrace_oneagent_install_linux" {
  source = "./modules/dynatrace_oneagent_install"

  ip_address = "${var.ip_address}"
  user = "${var.user}"
  password = "${var.password}"
  private_key = "${var.private_key}"
  dynatrace_env_id = "${var.dynatrace_env_id}"
  dynatrace_api_token = "${var.dynatrace_api_token}"
  dynatrace_logs = "${var.dynatrace_logs}"
}
