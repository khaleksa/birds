FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client \
  && mkdir /cloud

WORKDIR /cloud

COPY . /cloud
#COPY Gemfile /cloud/Gemfile
#COPY Gemfile.lock /cloud/Gemfile.lock

ENV BUNDLE_GEMFILE='./Gemfile'
ENV GEM_HOME=/bundle
ENV PATH=$GEM_HOME/bin:$PATH
ENV BUNDLE_PATH=$GEM_HOME
ENV BUNDLE_BIN=$GEM_HOME/bin
ENV RAILS_ENV='production'

RUN bundle config --global path "$GEM_HOME" \
  && bundle config --global bin "$GEM_HOME/bin" \
  && gem install bundler -v 1.17.1 \
  && bundle install

RUN bundle exec rails assets:precompile

## Add a script to be executed every time the container starts.
#COPY bin/init.sh /usr/bin/
#RUN chmod +x /usr/bin/init.sh
#ENTRYPOINT ["/usr/bin/init.sh"]

EXPOSE 3000

# Start the main process.
#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD exec rails server -b '0.0.0.0' -p $PORT
