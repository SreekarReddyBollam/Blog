FROM ruby:2.6.5
WORKDIR /app
COPY . /app
RUN bin/bundle install --jobs 20 --retry 5
CMD ["rails", "server", "-b", "0.0.0.0"]
