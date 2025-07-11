FROM golang:1.19 AS builder
WORKDIR /usr/starchain

COPY . .
RUN go run build/ci.go install

FROM golang:1.19 AS runner
WORKDIR /usr/starchain

COPY --from=builder /usr/starchain/build/bin/geth /usr/local/bin
COPY testnet.entrypoint.sh /usr/starchain/

RUN chmod +x testnet.entrypoint.sh

ENV BOOTNODES=""

CMD [ "sh", "-c", "./testnet.entrypoint.sh" ]