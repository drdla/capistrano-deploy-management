module CapistranoDeployManagement
  module Puma
    def self.load_into(configuration)
      configuration.load do

        # set(:puma_config)   { "#{current_path}/config/puma.rb" }
        set(:puma_pidfile)  { "#{deploy_to}/shared/pids/puma.pid" }
        set(:puma_pid)      { "cat #{deploy_to}/shared/pids/puma.pid" }

        namespace :puma do
          desc 'Restart puma.'
          task :restart, :roles => :app, :except => {:no_release => true} do
            puma.stop
            puma.start
          end

          desc 'Start puma.'
          task :start, :roles => :app, :except => {:no_release => true} do
            # run "cd #{current_path} && puma -C #{puma_config}"
            # TODO: fix hardcoded port setting by using a config file
            # run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rails s puma --port 3005 --pidfile #{puma_pidfile} -e #{rails_env}"
            run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rails s puma --port 3005 -e #{rails_env}"
          end

          desc 'Stop puma.'
          task :stop, :roles => :app, :except => {:no_release => true} do
            run "test -s #{puma_pidfile} && kill $(#{puma_pid}) || echo 'puma not running. nothing to kill.'"
          end
        end

        after 'deploy:restart', 'puma:restart'

      end
    end
  end
end