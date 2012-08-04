module CapistranoDeployManagement
  module RailsAssets
    def self.load_into(configuration)
      configuration.load do

        use_recipe :rails

        namespace :deploy do
          namespace :assets do
            # desc 'Precompile assets.'
            # task :precompile do
            #   run "cd #{current_path} && RAILS_ENV=#{rails_env} RAILS_GROUPS=assets #{rake} assets:precompile"
            # end

            # desc 'Clean assets.'
            # task :clean do
            #   run "cd #{current_path} && RAILS_ENV=#{rails_env} RAILS_GROUPS=assets #{rake} assets:clean"
            # end

            desc 'Clear application cache (e.g. Memcached).'
            task :refresh_cache, roles: :app do
              run "cd #{current_path} && rake cache:clear RAILS_ENV=#{rails_env}"
              # Requires this rake task: (include here!?)
              # namespace :cache do
              #   desc 'Clear memcache'
              #   task clear: :environment do
              #     Rails.cache.clear
              #   end
              # end
            end
          end
        end

        # before  'deploy:assets:precompile', 'deploy:assets:clean'
        # after   'deploy:assets:precompile', 'deploy:assets:refresh_cache'
        after   'deploy:update', 'deploy:assets:refresh_cache'

      end
    end
  end
end