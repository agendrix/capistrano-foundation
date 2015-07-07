namespace :load do
  task :defaults do
    set :puma_init_name, "#{fetch(:foreman_app_name)}-web"
    set :puma_pid_path,  "#{shared_path}/tmp/pids/puma.pid"
  end
end

namespace :puma do
  desc "Start puma workers"
  task :start do
    on roles(:app) do
      with rails_env: fetch(:env), rack_env: fetch(:env) do
        sudo "start #{fetch(:puma_init_name)}"
      end
    end
  end

  desc "Stop puma workers"
  task :stop do
    on roles(:app) do
      with rails_env: fetch(:env), rack_env: fetch(:env) do
        sudo "stop #{fetch(:puma_init_name)}"
      end
    end
  end

  desc "Phased-restart puma workers (if running), start it otherwise"
  task :smart_restart do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:env), rack_env: fetch(:env) do
          if test("[ -f #{fetch(:puma_pid_path)} ]") && test("kill -0 $( cat #{fetch(:puma_pid_path)} )")
            execute :bundle, :exec, :pumactl, "-P tmp/pids/puma.pid", "phased-restart"
          else
            sudo "start #{fetch(:puma_init_name)}"
          end
        end
      end
    end
  end
  after "deploy:published", "puma:smart_restart"

  desc "Restart puma workers"
  task :restart do
    invoke "puma:stop"
    invoke "puma:start"
  end
end
