FROM ruby:3.3.1 AS builder

RUN apt update --fix-missing
RUN apt install -y build-essential libpq-dev libjpeg-dev \
    libpng-dev imagemagick nano yarn git-core curl openssl libssl-dev

RUN rm -rf /var/lib/apt/lists/* \
    && apt update -qq \
    && apt-get install -y nodejs

FROM builder AS server

RUN mkdir -p /app
ENV APP_PATH=/app/
ADD . $APP_PATH
WORKDIR $APP_PATH
RUN bundle install -j8
RUN bundle config build.nokogiri --use-system-libraries
ENV image_name=aghour-backend
EXPOSE 3000

CMD ["sh", "bin/server"]