FROM ruby:2.6.5-alpine

EXPOSE 3000

RUN apk add --update --no-cache \
      bash \
      build-base \
      git \
      less \
      linux-headers \
      nodejs \
      postgresql-dev \
      sqlite-dev \
      tzdata \
      yarn 

RUN gem install bundler

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install 

COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY . ./ 

ENTRYPOINT ["./entrypoints/start.sh"]