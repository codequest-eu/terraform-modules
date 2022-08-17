FROM debian:11-slim

# Create dev user
ARG GID=1000
ARG UID=1000
RUN groupadd --gid ${GID} dev
RUN useradd \
  --uid ${UID} \
  --gid ${GID} \
  --shell "/usr/bin/bash" \
  --create-home \
  dev

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  ca-certificates \
  unzip \
  jq \
  git \
  make

WORKDIR /tmp

# Install terraform
RUN \
  ARCH=$(dpkg --print-architecture) \
  && curl -LO https://releases.hashicorp.com/terraform/1.2.5/terraform_1.2.5_linux_$ARCH.zip \
  && echo \
  '281344ed7e2b49b3d6af300b1fe310beed8778c56f3563c4d60e5541c0978f1b terraform_1.2.5_linux_amd64.zip\n' \
  '0544420eb29b792444014988018ae77a7c8df6b23d84983728695ba73e38f54a terraform_1.2.5_linux_arm64.zip' \
  | sha256sum --check --ignore-missing \
  && unzip terraform_1.2.5_linux_$ARCH.zip \
  && chmod +x terraform \
  && mv terraform /usr/bin/ \
  && rm terraform_1.2.5_linux_$ARCH.zip

# Install terraform-docs
RUN \
  ARCH=$(dpkg --print-architecture) \
  && curl -LO https://github.com/terraform-docs/terraform-docs/releases/download/v0.14.1/terraform-docs-v0.14.1-linux-$ARCH.tar.gz \
  && echo \
  'e68f15355bbec4d4016a8037b99e088d3196e4e12b16457880b5d910216af823 terraform-docs-v0.14.1-linux-arm64.tar.gz\n' \
  'f0a46b13c126f06eba44178f901bb7b6b5f61a8b89e07a88988c6f45e5fcce19 terraform-docs-v0.14.1-linux-amd64.tar.gz' \
  | sha256sum --check --ignore-missing \
  && tar -xzf terraform-docs-v0.14.1-linux-$ARCH.tar.gz \
  && chmod +x terraform-docs \
  && mv terraform-docs /usr/bin/ \
  && rm terraform-docs-v0.14.1-linux-$ARCH.tar.gz

# Install AWS CLI
RUN \
  case $(dpkg --print-architecture) in amd64) ARCH='x86_64';; arm64) ARCH='aarch64';; *) exit 1;; esac \
  && curl -LO https://awscli.amazonaws.com/awscli-exe-linux-$ARCH-2.7.15.zip \
  && echo \
  '0432c8d2227458400d1771f475bd314edf6fe229008c37bca5a8715f04ef6728 awscli-exe-linux-x86_64-2.7.15.zip\n' \
  '4b690f521c43c79c1b530615a67de310fe9ab7fdfe5eb5dec4f3a91908144192 awscli-exe-linux-aarch64-2.7.15.zip' \
  | sha256sum --check --ignore-missing \
  && unzip awscli-exe-linux-$ARCH-2.7.15.zip \
  && ./aws/install \
  && rm -r awscli-exe-linux-$ARCH-2.7.15.zip aws

# Disable the default AWS CLI pager which requires `less`
ENV AWS_PAGER=""

USER dev
RUN mkdir -p /home/dev/terraform-modules
WORKDIR /home/dev/terraform-modules
CMD [ bash ]
