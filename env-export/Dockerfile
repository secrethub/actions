FROM secrethub/cli:0.36.0

RUN apk add sed

COPY entrypoint.sh /entrypoint.sh
COPY app-info.sh /app-info.sh

ENTRYPOINT ["/entrypoint.sh"]
