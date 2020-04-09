FROM mcr.microsoft.com/azure-cli:2.3.1
LABEL maintainer="Rick Mak<rick.mak@gmail.com>"

RUN apk add sed

WORKDIR /app
RUN mkdir -p /app
ADD generate-list.sh /app/generate-list.sh
ADD copy.sh /app/copy.sh
ADD run.sh /app/run.sh

CMD ["/app/run.sh"]
