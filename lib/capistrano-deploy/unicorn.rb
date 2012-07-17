module CapistranoDeploy
  module Unicorn
    def self.load_into(configuration)
      configuration.load do
        set(:unicorn_pidfile) { "#{deploy_to}/shared/pids/unicorn.pid" }

        namespace :unicorn do
          desc 'Reload unicorn'
          task :reload, :roles => :app, :except => {:no_release => true} do
            run "test -s #{unicorn_pidfile} && kill -s USR2 `cat #{unicorn_pid}`"
          end

          desc 'Stop unicorn'
          task :stop, :roles => :app, :except => {:no_release => true} do
            run "kill -s QUIT `cat #{unicorn_pidfile}`"
          end

          desc 'Reexecute unicorn'
          task :reexec, :roles => :app, :except => {:no_release => true} do
            run "kill -s USR2 `cat #{unicorn_pidfile}`"
          end
        end
      end
    end
  end
end
