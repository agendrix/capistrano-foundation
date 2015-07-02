namespace :load do
  task :defaults do
    set :sidekiq_init_name, "#{fetch(:application)}-worker"
    set :sidekiq_pid_path,  "#{shared_path}/tmp/pids/sidekiq.pid"
  end
end

namespace :sidekiq do
  desc "Quiet sidekiq (stop accepting new work)"
  task :quiet do
    on roles(:app) do
      if test("[ -f #{fetch(:sidekiq_pid_path)} ]") && test("kill -0 $( cat #{fetch(:sidekiq_pid_path)} )")
        within current_path do
          with rails_env: fetch(:env), rack_env: fetch(:env) do
            execute :bundle, :exec, :sidekiqctl, "quiet", fetch(:sidekiq_pid_path)
          end
        end
      end
    end
  end
  after "deploy:starting", "sidekiq:quiet"

  desc "Start sidekiq workers"
  task :start do
    on roles(:app) do
      with rails_env: fetch(:env), rack_env: fetch(:env) do
        sudo "start #{fetch(:sidekiq_init_name)}"
      end
    end
  end
  after "deploy:published", "sidekiq:start"

  desc "Stop sidekiq workers"
  task :stop do
    on roles(:app) do
      if test("[ -f #{fetch(:sidekiq_pid_path)} ]") && test("kill -0 $( cat #{fetch(:sidekiq_pid_path)} )")
        with rails_env: fetch(:env), rack_env: fetch(:env) do
          sudo "stop #{fetch(:sidekiq_init_name)}"
        end
      end
    end
  end
  after "deploy:updated",  "sidekiq:stop"
  after "deploy:reverted", "sidekiq:stop"

  desc "Restart sidekiq workers"
  task :restart do
    invoke "sidekiq:stop"
    invoke "sidekiq:start"
  end
end
