# AG-tasks
for Attract Group
## Description
In this repo you can find architectural diagram of a simple web-application project on AWS and shell script for Docker application with nginx and php

## AWS diagram
Here you can see a simple web-application project with a few Availability Zones, white IP provided by EIP service and with own domain name provided by Domain Hosting and Route53 service. Apache Tomcat instances as a frontend servers in Auto Scaling Group. When we come to backend we can see RabbitMQ - is for communication between components of application. Then Memcache is a caching service for store temp data in memory just for optimization. MariaDB is a database SQL based server that stores data for application. 

## NGINX + PHP Docker application
in provisioning.sh you can see the bash script that allows to deploy NGINX + PHP application in swarm mode with limits of RAM and CPU. I deployed it on Amazon Linux, using Terraform code <details>
<summary>###</summary>

You can see in other repo on my page

</details>
