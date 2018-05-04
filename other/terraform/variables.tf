# =================================================================
# Licensed Materials - Property of IBM
# 5737-E67
# @ Copyright IBM Corporation 2018 All Rights Reserved
# US Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
# =================================================================

##############################################################
# CHAINED INPUT VARIABLES
##############################################################

variable "ip_address" { type = "string" description = "IP Address of the HOST to install the APM Agent." }
variable "user" { type = "string" description = "Userid to install the APM Agent, root reccomended." default = "root" }
variable "password" { type = "string" description = "Password of the installation user." }
variable "private_key" { type = "string" description = "Private key of the installation user. This value should be base64 encoded"}


##############################################################
# COMMAND VARIABLES
##############################################################

variable "dynatrace_env_id" { type = "string" description = "Dynatrace environment ID" }
variable "dynatrace_api_token" { type = "string" description = "Dynatrace API Token" }
variable "dynatrace_logs" { type = "string" description = "Provide application log files to Dynatrace?" default = "1" }
