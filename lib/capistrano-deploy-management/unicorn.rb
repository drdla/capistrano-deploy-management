module CapistranoDeployManagement
  module Unicorn
    def self.load_into(configuration)
      configuration.load do

        set(:unicorn_config)  { "#{current_path}/config/unicorn.rb" }
        set(:unicorn_pidfile) { "#{deploy_to}/shared/pids/unicorn.pid" }
        set(:unicorn_pid)     { "cat #{deploy_to}/shared/pids/unicorn.pid" }

        namespace :unicorn do
          desc 'Restart unicorn.'
          task :restart, :roles => :app do
            # FIXME: PID does not exist, thus restarting fails
            # run "cd #{current_path} && kill -s USR2 #{unicorn_pid}"
            unicorn.stop
            unicorn.start
          end

          desc 'Start unicorn.'
          task :start, :roles => :app do
            run "cd #{current_path} && bundle exec unicorn -c #{unicorn_config} -E #{rails_env} -D"
          end

          desc 'Stop unicorn.'
          task :stop, :roles => :app do
            # run "cd #{current_path} && kill $(#{unicorn_pid})"
            run "cd #{current_path} && test -s #{unicorn_pidfile} && kill $(#{unicorn_pid}) || echo 'Unicorn not running. Nothing to kill.'"
          end
        end

        after 'deploy:restart', 'unicorn:restart'

      end
    end
  end
end