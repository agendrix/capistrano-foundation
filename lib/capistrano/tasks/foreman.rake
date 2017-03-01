namespace :load do
  task :defaults do
    set :foreman_app_name, -> { fetch(:application) }
    set :foreman_custom_template, ""
  end
end

namespace :foreman do
  desc "Export the Procfile to Ubuntu upstart"
  task :export do
    on roles(:app) do |host|
      within release_path do
        tmp_path = "#{shared_path}/tmp/foreman"
        execute :bundle, :exec, "foreman export upstart #{tmp_path} -a #{fetch(:foreman_app_name)} -u #{fetch(:user)} -d #{current_path} -t #{fetch(:foreman_custom_template)}"
        sudo "mv #{tmp_path}/* /etc/init"
        sudo "rm -rf #{tmp_path}"
      end
    end
  end
  after "deploy:publishing", "foreman:export"
end
