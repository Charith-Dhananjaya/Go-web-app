FROM golang:1.25.1 as base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

# Final stage - distroless image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 3000

CMD ["./main"]

