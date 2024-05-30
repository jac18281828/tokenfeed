FROM ghcr.io/collectivexyz/foundry:latest

RUN python3 -m pip install slither-analyzer --break-system-packages

ARG PROJECT=tokenfeed
WORKDIR /workspaces/${PROJECT}
RUN chown -R foundry:foundry .
COPY --chown=foundry:foundry . .
ENV USER=foundry
USER foundry
ENV PATH=${PATH}:~/.cargo/bin:/usr/local/go/bin

RUN yamlfmt -lint .github/workflows/*.yml

RUN yarn install --dev
RUN forge install
RUN forge fmt --check
RUN python3 -m slither . --exclude-dependencies --exclude-info --exclude-low --exclude-medium
RUN yarn lint
RUN forge test -v
