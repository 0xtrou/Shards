FROM --platform=linux/amd64 shardsdotdev/rollup:dev

RUN npm install -g pnpm

RUN rm -rf /opstack-temp/
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

# Deploy Contracts and build genesis
CMD sh /opstack-temp/tools/bash_scripts/build_bedrock.sh