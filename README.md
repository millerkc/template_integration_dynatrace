# Dynatrace OneAgent Installation Template
Copyright IBM Corp. 2018
This code is released under the Apache 2.0 License.

## Description

This template will install Dynatrace OneAgent on a target host, and configure OneAgent for use with the Dynatrace service via the Internet.

Integration with a local (on-premises) Dyntatrace server is not supported in this release.

## Integration Method

Script Remote, executes on the remote host.

## Orchestration Reccomendation

This template must be executed after the successful creation of a Virtual Machine via a Terraform Template.

## Methods Implemented

- **on\_create** Installs and registers the APM Agent.
- **on\_delete** Not implemented. (Hosts cannot be explicitly removed from a Dynatrace account. Hosts are removed from the Dynatrace user interface automatically if they are inactive for 72 hours or more.)

## Prerequisites

- An active Dynatrace account (trial accounts are OK.)
- The target server must be able to reach Dynatrace's servers via the internet.
- The target server must have greater than **150MB available** in `/tmp`.
- The target server must have remote logins enabled.

## Input Parameters
|Variable|Description|
|--- |--- |
|ip\_address|IP Address of the target server.|
|user|User on the target server to execute the installation (`root` required in this release)|
|password|Password of the `root` user.|
|dynatrace\_env\_id|Your Dynatrace Environment ID. This is the string that precedes `live.dynatrace.com` in the URL provided to you for installation when logged in to `dynatrace.com` (**Deploy Dynatrace > Start Installation > Linux**)|
|dynatrace\_api\_token|Your Dynatrace API Token. This token must have InstallerDownload scope. A token with the required scope can be found by default when logged in to `dynatrace.com` at **Settings > Integration > Platform as a Service**.|
|dynatrace\_logs|Enable sending stdout/stderr logs from monitored processes to Dynatrace. **1** (Default) = Enabled, **0** = Disabled|

