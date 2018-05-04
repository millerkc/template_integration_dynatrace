#!/bin/bash
# =================================================================
# Copyright 2018 IBM Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# =================================================================

# Check if a command exists
command_exists() {
  type "$1" &> /dev/null;
}


TEMP_DIR=/tmp
SOURCE_SUBDIR=oneagent
mkdir -p $TEMP_DIR/$SOURCE_SUBDIR
if [ $? -ne 0 ]; then
	echo "Failed to create $TEMP_DIR/$SOURCE_SUBDIR"
	exit -1
fi

# Check Parameters

if [ "$#" -lt 4 ]; then
    echo "Usage: $0 apm_source source_type source_subdir apm_dir [agents]" >&2
    exit 1
fi



# Assign Parameters

SOURCE=$1
SOURCE_TYPE=http
#SOURCE_SUBDIR=$3
#APM_DIR=$4
DYNATRACE_ENV_ID=$1
DYNATRACE_API_TOKEN=$2
DYNATRACE_LOCAL_FILE=Dynatrace-OneAgent-Linux-1.139.187.sh
DYNATRACE_LOGS=$3


# Download dynatrace installer and cert for verification
# keeping test for source type in case we want to support other sources later

cd $TEMP_DIR
case $SOURCE_TYPE  in
    http)
    	if command_exists curl; then
        	curl -o ${DYNATRACE_LOCAL_FILE} "https://${DYNATRACE_ENV_ID}.live.dynatrace.com/api/v1/deployment/installer/agent/unix/default/latest?Api-Token=${DYNATRACE_API_TOKEN}&arch=x86&flavor=default"
        	curl -O https://ca.dynatrace.com/dt-root.cert.pem
        else
        	echo "curl command not available on host"
        	exit 1
        fi
        ;;
    *) exit 1
esac

# verify installer download
( echo 'Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="--SIGNED-INSTALLER"'; echo ; echo ; echo '----SIGNED-INSTALLER' ; cat Dynatrace-OneAgent-Linux-1.139.187.sh ) | openssl cms -verify -CAfile dt-root.cert.pem > /dev/null
if [ $? -ne 0 ]; then
	echo "Failed to verify the installer download"
	exit -1
fi


# Install Agent
/bin/sh Dynatrace-OneAgent-Linux-1.139.187.sh  APP_LOG_CONTENT_ACCESS=${DYNATRACE_LOGS}
if [ $? -ne 0 ]; then
	echo "Dynatrace OneAgent installation failed"
	exit -1
fi


# Cleanup
if [ -n "$TEMP_DIR" ]; then
	rm $TEMP_DIR/$DYNATRACE_LOCAL_FILE
	rm $TEMP_DIR/dt-root.cert.pem
fi
