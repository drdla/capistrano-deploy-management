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
            unicorn.stop
            unicorn.start
            # run "cd #{current_path} && kill -USR2 #{unicorn_pid}"
          end

          desc 'Start unicorn.'
          task :start, :roles => :app do
            run "cd #{current_path} && unicorn -c #{unicorn_config} -E #{rails_env} -D"
          end

          desc 'Stop unicorn.'
          task :stop, :roles => :app do
            run "test -s #{unicorn_pidfile} && kill $(#{unicorn_pid}) || echo 'unicorn not running. nothing to kill.'"
          end
        end

        after 'deploy:restart', 'unicorn:restart'

      end
    end
  end
end