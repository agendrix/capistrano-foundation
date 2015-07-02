namespace :foreman do
  desc "Export the Procfile to Ubuntu upstart"
  task :export do
    on roles(:app) do |host|
      within release_path do
        sudo "bundle exec foreman export upstart /etc/init -a #{fetch(:application)} -u #{fetch(:user)} -d #{current_path}"
      end
    end
  end
  after "deploy:publishing", "foreman:export"
end
