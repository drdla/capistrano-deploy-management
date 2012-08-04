module CapistranoDeployManagement
  module Memcached
    def self.load_into(configuration)
      configuration.load do

        namespace :deploy do
          namespace :memcached do
            desc "Restart the Memcache daemon."
            task :restart, :roles => :app do
              deploy.memcached.stop
              deploy.memcached.start
            end

            desc "Start the Memcache daemon."
            task :start, :roles => :app do
              invoke_command "memcached -P #{current_path}/shared/log/memcached.pid -d", :via => run_method
            end

            desc "Stop the Memcache daemon."
            task :stop, :roles => :app do
              pid_file = "#{current_path}/shared/log/memcached.pid"
              invoke_command("killall -9 memcached", :via => run_method) if File.exist?(pid_file)
            end
          end
        end

      end
    end
  end
end