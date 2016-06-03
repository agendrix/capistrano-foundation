namespace :logrotate do
  task :setup do
    on roles(:app) do
      destination = "/etc/logrotate.d/#{fetch(:application)}"
      template "logrotate.erb", "/tmp/logrotate_#{fetch(:application)}", as_root: true
      sudo "mv /tmp/logrotate_#{fetch(:application)} #{destination}"
      sudo "chown root #{destination}"
      sudo "chmod 600 #{destination}"
    end
  end

  after "deploy:publishing", "logrotate:setup"
end
