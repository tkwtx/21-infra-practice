FROM ruby:2.7.2 AS nodejs

WORKDIR /tmp

RUN curl -LO https://nodejs.org/dist/v14.15.5/node-v14.15.5-linux-x64.tar.xz && \
	tar xvf node-v14.15.5-linux-x64.tar.xz && \
	mv node-v14.15.5-linux-x64 node

FROM ruby:2.7.2

COPY --from=nodejs /tmp/node /opt/node
ENV PATH /opt/node/bin:$PATH

RUN apt update -y && \
	apt upgrade -y && \
	apt install -y \
		build-essential \
		mariadb-client \
		nginx \
		npm \
		supervisor \
		vim \
		wget

RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH /home/rails/.yarn/bin:/home/rails/.config/yarn/global/node_modules/.bin:$PATH

WORKDIR /var/www/dev.rails.me

COPY conf/nginx/dev.rails.me.conf /etc/nginx/conf.d/
COPY conf/supervisor/app.conf /etc/supervisor/conf.d/

CMD ["/usr/bin/supervisord"]