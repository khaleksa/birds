FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /birds
WORKDIR /birds

COPY Gemfile /birds/Gemfile
COPY Gemfile.lock /birds/Gemfile.lock

ENV BUNDLE_GEMFILE='./Gemfile'
ENV GEM_HOME=/bundle
ENV PATH=$GEM_HOME/bin:$PATH
ENV BUNDLE_PATH=$GEM_HOME
ENV BUNDLE_BIN=$GEM_HOME/bin

RUN bundle config --global path "$GEM_HOME" \
  && bundle config --global bin "$GEM_HOME/bin"

RUN gem install bundler -v 1.17.1
RUN bundle install

COPY . /birds

## Add a script to be executed every time the container starts.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
## ENTRYPOINT ["entrypoint.sh"]
#RUN ./entrypoint.sh

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]