Capistrano::foundation
======

This gem provides a solid basic rails stack (might support more stuff in the future) for Capistrano 3.x

Installation
------

Add this to your application's Gemfile:

    gem "capistrano", "~> 3.1"
    gem "capistrano-foundation", github: "agendrix/capistrano-foundation"

And then execute:

    $ bundle install

Usage
------

    # Capfile

    require 'capistrano/foundation'

    # Or if you want to pick specific tasks
    require 'capistrano/foundation/nginx'
    ...

Configurable options:

    set :env,                      -> { fetch(:rack_env, fetch(:rails_env, fetch(:stage))) }
    set :force_www_url,            "www.domain.com"
    set :server_name,              "www.domain.com"
    set :ssl_certificate_path,     nil
    set :ssl_certificate_key_path, nil
    set :puma_init_name,           "#{fetch(:foreman_app_name)}-web"
    set :puma_pid_path,            "#{shared_path}/tmp/pids/puma.pid"
    set :sidekiq_init_name,        "#{fetch(:foreman_app_name)}-worker"
    set :sidekiq_pid_path,         "#{shared_path}/tmp/pids/sidekiq.pid"

Contributing
------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## About

![agendrix](https://user-images.githubusercontent.com/304461/31439242-6fe93940-ae59-11e7-8829-9b7a992fb87f.png)

[Agendrix](http://www.agendrix.com) is a team of passionate on a mission to create more pleasant and productive workplaces with innovative software, an exceptional team and unparalleled customer service.

## License

This project is © [Agendrix](http://www.agendrix.com). It is free software and may be redistributed under the terms specified in the LICENSE file.
