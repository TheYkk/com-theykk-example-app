FROM theykk.com/library/go:1.13-alpine AS build-env
WORKDIR /go/src/app

ADD main.go /go/src/app/

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o app .

FROM scratch
WORKDIR /app
COPY --from=build-env /go/src/app/app .
ENTRYPOINT [ "./app" ]