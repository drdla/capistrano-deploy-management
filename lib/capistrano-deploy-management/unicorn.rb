module CapistranoDeployManagement
  module Unicorn
    def self.load_into(configuration)
      configuration.load do

        set(:unicorn_config)  { "#{current_path}/config/unicorn.rb" }
        # FIXME: Restarting fails, because PID does not exist -> symlink already points to new, empty folder
        # set(:unicorn_pidfile) { "#{deploy_to}/shared/pids/unicorn.pid" }
        # set(:unicorn_pid)     { "cat #{deploy_to}/shared/pids/unicorn.pid" }
        set(:unicorn_pidfile) { "#{previous_release}/tmp/pids/unicorn.pid" }

        namespace :unicorn do
          desc 'Restart unicorn.'
          task :restart, :roles => :app do
            run "if [ -f #{unicorn_pidfile} ] && [ -e 'cat #{unicorn_pidfile}' ]; then #{try_sudo} kill -s USR2 'cat #{unicorn_pidfile}'; else cd #{current_path} && bundle exec unicorn -c #{unicorn_config} -E #{rails_env} -D; fi"
            # unicorn.stop
            # unicorn.start
          end

          desc 'Start unicorn.'
          task :start, :roles => :app do
            run "cd #{current_path} && bundle exec unicorn -c #{unicorn_config} -E #{rails_env} -D"
          end

          desc 'Stop unicorn.'
          task :stop, :roles => :app do
            run "cd #{current_path} && test -s #{unicorn_pidfile} && #{try_sudo} kill -QUIT 'cat #{unicorn_pidfile}' || echo 'Unicorn not running. Nothing to kill.'"
          end
        end

        after 'deploy:restart', 'unicorn:restart'

      end
    end
  end
end