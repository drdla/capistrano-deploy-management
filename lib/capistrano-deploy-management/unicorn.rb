module CapistranoDeployManagement
  module Unicorn
    def self.load_into(configuration)
      configuration.load do

        set(:unicorn_config) { "#{current_path}/config/unicorn.rb" }
        set(:unicorn_pidfile) { "cat #{deploy_to}/shared/pids/unicorn.pid" }

        namespace :unicorn do
          desc 'Restart unicorn.'
          task :restart, :roles => :app, :except => {:no_release => true} do
            unicorn.stop
            unicorn.start
          end

          desc 'Start unicorn.'
          task :start, :roles => :app, :except => {:no_release => true} do
            run "cd #{current_path} && unicorn -c #{unicorn_pidfile} -E production -D"
          end

          desc 'Stop unicorn.'
          task :stop, :roles => :app, :except => {:no_release => true} do
            run "cd #{current_path} && kill $(#{unicorn_pidfile})"
          end
        end

        after 'deploy:restart', 'unicorn:restart'

      end
    end
  end
end