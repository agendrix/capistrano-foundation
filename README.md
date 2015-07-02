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
    set :ssl_certificate_filename, nil
    set :puma_init_name,           "#{fetch(:application)}-web"
    set :puma_pid_path,            "#{shared_path}/tmp/pids/puma.pid"
    set :sidekiq_init_name,        "#{fetch(:application)}-worker"
    set :sidekiq_pid_path,         "#{shared_path}/tmp/pids/sidekiq.pid"

Contributing
------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## About

Agendrix is small team of passionate who enjoy writing good code that solves interesting problems. We consider ourselves as friendly, hard workers and dynamic. We love to see things differently and strongly believe in progress and innovation.

At Agendrix, we use open source software a lot and that's why we try hard to share as much as possible.

## License

This project is © [Agendrix](http://www.agendrix.com) It is free software and may be redistributed under the terms specified in the LICENSE file.
