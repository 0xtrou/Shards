FROM --platform=linux/amd64 ubuntu:22.04

# Update package lists and install necessary dependencies
RUN apt-get update && apt-get install -y \
    git \
    make \
    wget \
    gcc \
    jq \
    libusb-1.0-0-dev \
    libc6 \
    curl

# Install Node.js 16.x
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Install npm
#RUN apt-get install -y npm

# Install Yarn
RUN npm install --global yarn pnpm


# Set up Go environment variables
ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

# Define the Go version to install
ARG GO_VERSION=1.20

# Download and install Go
RUN wget -q https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
    && rm go${GO_VERSION}.linux-amd64.tar.gz

# Install Foundry
SHELL ["/bin/bash", "-c"]

RUN curl -L https://foundry.paradigm.xyz | bash
RUN source ~/.bashrc
ENV PATH="/root/.foundry/bin:${PATH}"
RUN foundryup

RUN mkdir /opstack-temp
COPY ./optimism /opstack-temp/optimism
COPY ./tools /opstack-temp/tools
COPY ./op-geth /opstack-temp/op-geth

RUN cd /opstack-temp/  \
    && cd optimism \
    && foundryup \
    && pnpm install \
    && make op-node op-batcher op-proposer \
    && pnpm build

RUN cd /opstack-temp/ \
    && cd op-geth \
    && make geth

# CLONE ENV INJECTOR & BUILD
RUN cd /opstack-temp/ \
    && cd tools \
    && yarn install
