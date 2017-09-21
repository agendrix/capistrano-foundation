namespace :load do
  task :defaults do
    set :foreman_app_name, -> { fetch(:application) }
    set :foreman_custom_template, ""
  end
end

namespace :foreman do
  desc "Export the Procfile to Ubuntu upstart"
  task :export do
    on roles(:app, :worker) do |host|
      within release_path do
        formation_option = "all=1"

        if host.has_role?(:worker) && !host.has_role?(:app)
          formation_option += ",web=0"
        elsif host.has_role?(:app) && !host.has_role?(:worker)
          formation_option += ",worker=0"
        end

        tmp_path = "#{shared_path}/tmp/foreman"
        execute :bundle, :exec, "foreman export upstart #{tmp_path} -a #{fetch(:foreman_app_name)} -u #{fetch(:user)} -d #{current_path} -t #{fetch(:foreman_custom_template)} -m #{formation_option}"
        sudo "chown root:root -R #{tmp_path}/*"
        sudo "chmod 644 #{tmp_path}/*"
        sudo "mv #{tmp_path}/* /etc/init"
        sudo "rm -rf #{tmp_path}"
      end
    end
  end
  after "deploy:publishing", "foreman:export"
end
