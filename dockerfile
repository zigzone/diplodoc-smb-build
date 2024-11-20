FROM node:20

WORKDIR /app

COPY ./src/package*.json .
COPY ./src/scripts ./scripts
RUN npm install

RUN apt-get update && \
apt-get install -y samba samba-common-bin && \
rm -rf /var/lib/apt/lists/*

COPY ./smb.conf /etc/samba/smb.conf

RUN useradd -m -s /bin/bash doc-editor && \
(echo "ohg0Gai7"; echo "ohg0Gai7") | smbpasswd -a -s doc-editor

RUN mkdir -p /app/docs-html && \
    chown -R doc-editor:doc-editor /app/docs-html && \
    chmod -R 770 /app/docs-html

RUN mkdir -p /app/docs && \
    chown -R doc-editor:doc-editor /app/docs && \
    chmod -R 770 /app/docs

COPY ./docs /app/docs
# RUN chmod -R 0777 /app/docs-html && chmod -R 0777 /app/docs 