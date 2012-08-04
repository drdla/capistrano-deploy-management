module CapistranoDeployManagement
  module Puma
    def self.load_into(configuration)
      configuration.load do

        set(:puma_config) { "#{current_path}/config/puma.rb" }
        set(:puma_pidfile) { "cat #{deploy_to}/shared/pids/puma.pid" }

        namespace :puma do
          desc 'Restart puma.'
          task :restart, :roles => :app, :except => {:no_release => true} do
            puma.stop
            puma.start
          end

          desc 'Start puma.'
          task :start, :roles => :app, :except => {:no_release => true} do
            run "cd #{current_path} && puma -c #{puma_pidfile} -E production -D"
          end

          desc 'Stop puma.'
          task :stop, :roles => :app, :except => {:no_release => true} do
            run "cd #{current_path} && kill $(#{puma_pidfile})"
          end
        end

        after 'deploy:restart', 'puma:restart'

      end
    end
  end
end