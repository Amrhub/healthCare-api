FROM ruby

WORKDIR /home/app

ENV PORT 3000

EXPOSE $PORT

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN gem install rails bundler
RUN gem install rails
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client

ENTRYPOINT [ "/bin/bash" ]