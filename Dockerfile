FROM ruby:2.7.0
WORKDIR /app
COPY . /app
RUN gem install bundler
RUN bin/bundle install --jobs 20 --retry 5
CMD ["rails", "server", "-b", "0.0.0.0"]
