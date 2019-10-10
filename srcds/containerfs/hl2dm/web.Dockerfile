FROM nginx
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        curl unzip p7zip-full curl wget bzip2 \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*


USER root

RUN mkdir /assets
WORKDIR /assets/
ADD ./hl2mp/ ./

RUN mv /assets/* /usr/share/nginx/html/
RUN sed -i 's/localhost/_/' /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]





