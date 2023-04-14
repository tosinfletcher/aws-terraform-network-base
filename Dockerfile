# Base image
FROM ubuntu:latest

# Install requiered packages
RUN apt-get update \
  && apt-get install -y gnupg curl wget unzip git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get update \
  && apt-get install -y nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Terraform
ENV TERRAFORM_VERSION="1.4.4"
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && mv terraform /usr/local/bin/ \
  && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip


# Set the entrypoint
CMD ["/bin/bash"]