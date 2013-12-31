$monit_path = '/usr/bin/monit'

def run_with_monit(action, process)
  "#{$monit_path} #{action} #{process}"
end

def start_with_monit(process)
  run_with_monit('start', process)
end

def stop_with_monit(process)
  run_with_monit('stop', process)
end

namespace :deploy do

  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      start_with_monit(monit_app_name)
    end
  end

  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      stop_with_monit(monit_app_name)
    end
  end

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      stop_with_monit($monit_app_name)
      start_with_monit($monit_app_name)
    end
  end
end
