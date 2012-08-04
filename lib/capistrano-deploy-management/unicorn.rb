module CapistranoDeployManagement
  module Unicorn
    def self.load_into(configuration)
      configuration.load do

        set(:unicorn_config)  { "#{current_path}/config/unicorn.rb" }
        set(:unicorn_pidfile) { "#{deploy_to}/shared/pids/unicorn.pid" }
        set(:unicorn_pid)     { "cat #{unicorn_pidfile}" }

        namespace :unicorn do
          desc 'Restart unicorn.'
          task :restart, :roles => :app, :except => {:no_release => true} do
            unicorn.stop
            unicorn.start
          end

          desc 'Start unicorn.'
          task :start, :roles => :app, :except => {:no_release => true} do
            run "cd #{current_path} && unicorn -c #{unicorn_config} -E production -D"
          end

          desc 'Stop unicorn.'
          task :stop, :roles => :app, :except => {:no_release => true} do
            run "if test -s #{unicorn_pidfile}; then cd #{current_path} && kill $(#{unicorn_pid}) fi"
          end
        end

        after 'deploy:restart', 'unicorn:restart'

      end
    end
  end
end