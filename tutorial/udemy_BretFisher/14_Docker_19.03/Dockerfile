From golang as build
COPY releaseparty.go .
RUN go build releaseparty.go

FROM scratch
COPY --from=build /go/releaseparty /releaseparty
CMD ["/releaseparty"]
