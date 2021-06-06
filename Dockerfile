FROM ruby:2.7.0
WORKDIR /app
COPY . /app
RUN gem install bundler && gem install mimemagic -v '0.3.10'
RUN bin/bundle install --jobs 20 --retry 5
CMD ["rails", "server", "-b", "0.0.0.0"]
