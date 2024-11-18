FROM node:20

WORKDIR /app

COPY ./src/package*.json .
COPY ./src/scripts ./scripts
RUN npm install
RUN mkdir /app/docs-html && mkdir /app/docs 

#директория приложе# Установка утилит для установки Samba
RUN apt-get update && \
apt-get install -y samba samba-common-bin && \
rm -rf /var/lib/apt/lists/*

COPY ./smb.conf /etc/samba/smb.conf
RUN chmod -R 0777 /app/docs-html && chmod -R 0777 /app/docs 