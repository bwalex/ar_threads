## Setup

Edit configuration in

    config/database.yml


Run

    bundle install

    bundle exec rake db:migrate


## Run tests with puma

    bundle exec puma -C puma.rb

    ab -n 10000 -c 32 http://127.0.0.1:9292/test



## Run tests with unicorn

    bundle exec unicorn -c unicorn.rb

    ab -n 10000 -c 32 http://127.0.0.1:9292/test
