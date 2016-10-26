#
# Require ENV
# - DIGDAG_ENDPOINT
#
FROM ytakagi/ruby:2.3-slim

ENV LANG C.UTF-8

RUN echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
                    curl \
                    openjdk-8-jre-headless \
 && rm -rf /var/lib/apt/lists/*

RUN curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
 && chmod +x /usr/local/bin/digdag

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . .

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bundle", "exec", "ruby", "app.rb", "-o", "0.0.0.0"]
