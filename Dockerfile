FROM golang

#Install Deps
RUN apt update
RUN apt install -y jq unzip

#Install Terraform
RUN wget https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip
RUN unzip terraform_0.14.7_linux_amd64.zip -d /usr/local/bin/
RUN chmod +x /usr/local/bin/terraform

#Install Terragrunt
ADD https://github.com/gruntwork-io/terragrunt/releases/download/v0.28.7/terragrunt_linux_amd64 /usr/local/bin/terragrunt
RUN chmod +x /usr/local/bin/terragrunt

# Proxmox Module Install
RUN export OS=linux
RUN export ARCH=amd64
RUN GO111MODULE=on go get -v github.com/Telmate/terraform-provider-proxmox/cmd/terraform-provider-proxmox
RUN mkdir -p ~/.terraform.d/plugins/terraform.example.com/telmate/proxmox/1.0.0/linux_amd64
RUN mv /go/bin/terraform-provider-proxmox    ~/.terraform.d/plugins/terraform.example.com/telmate/proxmox/1.0.0/linux_amd64/
