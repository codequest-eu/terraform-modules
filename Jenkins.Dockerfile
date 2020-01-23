# hashicorp/terraform is based on alpine 3.11
FROM hashicorp/terraform:0.12.19

# Install AWS CLI
RUN apk --no-cache add python3 py3-pip groff
RUN pip3 install awscli==1.17.3

# Install other tools
RUN apk --no-cache add \
  git \
  jq \
  go \
  make \
  curl

# Install tflint
RUN curl -L -o /tmp/tflint.zip "https://github.com/terraform-linters/tflint/releases/download/v0.13.4/tflint_linux_amd64.zip" && \
  unzip /tmp/tflint.zip -d /tmp/ && \
  mv /tmp/tflint /usr/local/bin && \
  rm /tmp/tflint.zip

# build custom tools
RUN mkdir -p /opt/terraform-modules/tools
ADD Makefile /opt/terraform-modules
ADD tools /opt/terraform-modules/tools
RUN cd /opt/terraform-modules && make tools

ENV TOOLS_BIN=/opt/terraform-modules/tools/bin

# Clear the hashicorp/terraform default entrypoint
ENTRYPOINT [ ]
CMD ["/bin/sh"]
