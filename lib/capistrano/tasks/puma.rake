namespace :load do
  task :defaults do
    set :puma_init_name, -> { "#{fetch(:foreman_app_name, fetch(:application))}-web" }
    set :puma_pid_path,  -> { "#{shared_path}/tmp/pids/puma.pid" }
  end
end

namespace :puma do
  desc "Start puma"
  task :start do
    on roles(:app) do
      with rails_env: fetch(:env), rack_env: fetch(:env) do
        sudo "start #{fetch(:puma_init_name)}"
      end
    end
  end

  desc "Stop puma"
  task :stop do
    on roles(:app) do
      with rails_env: fetch(:env), rack_env: fetch(:env) do
        sudo "stop #{fetch(:puma_init_name)}"
      end
    end
  end

  desc "Restart puma"
  task :restart do
    on roles(:app) do
      with rails_env: fetch(:env), rack_env: fetch(:env) do
        sudo "restart #{fetch(:puma_init_name)}"
      end
    end
  end

  desc "Reload puma workers (phased-restart)"
  task :reload do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:env), rack_env: fetch(:env) do
          begin
            sudo "reload #{fetch(:puma_init_name)}"
          rescue Exception => error
            invoke "puma:restart"
          end
        end
      end
    end
  end
  after "deploy:published", "puma:reload"
end
