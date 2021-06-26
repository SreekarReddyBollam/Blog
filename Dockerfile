FROM ruby:2.7.0
WORKDIR /app
RUN gem install bundler && gem install mimemagic -v '0.3.10'
COPY Gemfile Gemfile.lock ./
RUN bundle config --local build.sassc --disable-march-tune-native && bundle install --jobs 20 --retry 5
COPY . ./
CMD ["rails", "server", "-b", "0.0.0.0"]
