FROM ruby:3.3.1 AS builder

RUN apt update --fix-missing

RUN apt install -y build-essential libpq-dev libjpeg-dev libpng-dev imagemagick nano yarn git-core curl openssl libssl-dev nodejs

RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
ENV APP_PATH /app/
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install -j8

FROM builder AS server
ENV image_name=aghour-backend
ADD . $APP_PATH
WORKDIR $APP_PATH
EXPOSE 4040

CMD ['sh' 'bin/server']