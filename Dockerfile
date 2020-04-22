FROM alpine:3.11

ARG KUBECTL_VERSION="1.15.10"
ARG KUSTOMIZE_VERSION="3.5.4"

RUN apk add py-pip curl
RUN pip install awscli
RUN curl -L -o /usr/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/${KUBECTL_VERSION}/2020-02-22/bin/linux/amd64/kubectl
RUN chmod +x /usr/bin/kubectl

RUN curl -L -o kustomize.tar https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
  tar -zxf kustomize.tar && \
  chmod +x kustomize && \
  mv kustomize /usr/bin/kustomize && \
  rm -rf kustomize.tar

RUN curl -L -o /usr/bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x /usr/bin/aws-iam-authenticator

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
