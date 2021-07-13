FROM golang:latest
LABEL maintainer="Daniel Margolis <dan@af0.net>"
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o sts-mate .
EXPOSE 443

# Comma-separated list of domains to serve policies for.
ENV STS_DOMAIN "d4ve.email"
# Comma-separated list of MX.
ENV STS_MX "aspmx1.migadu.com,aspmx2.migadu.com"
ENV STS_MODE "testing"
ENV STS_MAX_AGE "604800"
# Usage:
#  --domain is the domain to serve a policy for.
#  --mirror_sts_from is the mail domain from which to proxy STS policies
#  --domain is the domain for which to serve a policy (if limited)
CMD ["sh", "-c", "./sts-mate --domain $STS_DOMAIN --sts_mx $STS_MX --sts_mode $STS_MODE --sts_max_age $STS_MAX_AGE"]
