module CapistranoDeployManagement
  module RailsAssets
    def self.load_into(configuration)
      configuration.load do

        use_recipe :rails

        namespace :deploy do
          namespace :assets do
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

        after   'deploy:update', 'deploy:assets:refresh_cache'

      end
    end
  end
end