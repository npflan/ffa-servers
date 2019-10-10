FROM nginx
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
	curl unzip p7zip-full curl wget bzip2 \
	ca-certificates \
    && rm -rf /var/lib/apt/lists/*


USER root

RUN mkdir /assets
WORKDIR /assets/
ADD ./build/download.sh ./
RUN chmod +x download.sh
RUN ./download.sh
RUN tar xvzf dhooks-2.2.0-hg132-linux.tar.gz -C ./
RUN tar xvzf sourcemod-*-linux.tar.gz -C ./
RUN tar xvzf mmsource-*-linux.tar.gz -C ./
RUN unzip -o prophunt-source.zip -d ./
RUN unzip -o tf2items.zip -d ./
RUN 7z x -o./ PHMapEssentialsBZ2.7z
RUN bash -c "cd ./maps/ && bunzip2 *.bz2"
RUN chmod -R ugo+rx  /assets/*

RUN mv /assets/* /usr/share/nginx/html/
RUN sed -i 's/localhost/_/' /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]