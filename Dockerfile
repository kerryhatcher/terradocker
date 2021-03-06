FROM ubuntu
MAINTAINER Brian Antonelli

ENV TERRAFORM_VERSION=0.8.7
ENV TF_ALKS_PROVIDER_VERSION=0.0.1

RUN apt-get update && apt-get install -y ca-certificates wget curl unzip


RUN mkdir /work
VOLUME [ "/work" ]
WORKDIR "/work"

RUN wget -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip /tmp/terraform.zip -d /usr/bin && \
  rm -rf /tmp/terraform.zip
RUN wget -O /usr/bin/terraform-provider-alks-linux-amd64 https://github.com/Cox-Automotive/terraform-provider-alks/releases/download/${TF_ALKS_PROVIDER_VERSION}/terraform-provider-alks-linux-amd64
RUN chmod a+x /usr/bin/terraform-provider-alks-linux-amd64
COPY .terraformrc /root/.terraformrc

ENTRYPOINT ["terraform"]
CMD ["version"]
