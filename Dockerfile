FROM ruby

RUN gem install cucumber selenium-webdriver google-api-client bundler
RUN gem update -y google-api-client

# CMD ["ruby yesmail_app.rb"]
CMD ["cucumber"]
