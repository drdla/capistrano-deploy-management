module CapistranoDeploy
  module Unicorn
    def self.load_into(configuration)
      configuration.load do
        set(:unicorn_pid) { "`cat #{deploy_to}/shared/pids/unicorn.pid`" }

        namespace :unicorn do
          desc 'Reload unicorn'
          task :reload, :roles => :app, :except => {:no_release => true} do
            run "test -f #{unicorn_pid} && kill -s USR2 #{unicorn_pid}"
          end

          desc 'Stop unicorn'
          task :stop, :roles => :app, :except => {:no_release => true} do
            run "kill -QUIT #{unicorn_pid}"
          end

          desc 'Reexecute unicorn'
          task :reexec, :roles => :app, :except => {:no_release => true} do
            run "kill -USR2 #{unicorn_pid}"
          end
        end
      end
    end
  end
end
