FROM ruby:3.2.2-bullseye

RUN apt update --fix-missing

RUN apt install -y build-essential libpq-dev libjpeg-dev libpng-dev imagemagick nano yarn git-core curl openssl libssl-dev nodejs

RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
ENV APP_PATH /app/
WORKDIR $APP_PATH
ADD . $APP_PATH

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle install -j8

CMD ['sh' 'bin/server']