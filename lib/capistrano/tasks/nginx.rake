namespace :load do
  task :defaults do
    set :server_name, "www.domain.com"
    set :force_www_url, false
  end
end

namespace :nginx do
  %w[start stop restart reload].each do |command|
    desc "#{command} nginx"
    task command do
      on roles(:web) do
        sudo "service nginx #{command}"
      end
    end
  end
  after "deploy:finishing", "nginx:reload"

  desc "Setup nginx configuration for this application"
  task :setup do
    on roles(:web) do
      template "nginx.erb", "/tmp/nginx_conf", as_root: true
      sudo "mv /tmp/nginx_conf /etc/nginx/sites-available/#{fetch(:application)}"
      sudo "ln -nfs /etc/nginx/sites-available/#{fetch(:application)} /etc/nginx/sites-enabled/#{fetch(:application)}"
    end
  end
  after "deploy:starting", "nginx:setup"
end
