namespace :load do
  task :defaults do
    set :inspeqtor_role, -> { :all }
    set :inspeqtor_bin, "/usr/bin/inspeqtorctl"
  end
end

namespace :inspeqtor do
  desc "Pause Inspeqtor monitoring"
  task :start do
    on roles(fetch(:inspeqtor_role)) do
      sudo "#{fetch(:inspeqtor_bin)} start deploy"
    end
  end
  after "deploy:check", "inspeqtor:start"

  desc "Resume Inspeqtor monitoring"
  task :finish do
    on roles(fetch(:inspeqtor_role)) do
      sudo "#{fetch(:inspeqtor_bin)} finish deploy"
    end
  end
  before "deploy:finished", "inspeqtor:finish"
end
