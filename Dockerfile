FROM ruby:3.0.0

RUN apt update --fix-missing

RUN apt install -y build-essential libpq-dev libjpeg-dev libpng-dev imagemagick nano yarn git-core curl openssl libssl-dev

RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
ENV APP_PATH /app/
WORKDIR $APP_PATH
ADD . $APP_PATH

RUN bundle update rails
RUN bundle install --jobs 4

CMD bash -c "rm -f tmp/pids/server.pid && rails s -p 3000 -b '0.0.0.0'"