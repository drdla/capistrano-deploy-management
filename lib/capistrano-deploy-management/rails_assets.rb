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
              # desc 'Clear memcache'
              # task clear: :environment do
              # Rails.cache.clear
              # end
              # end
            end

            desc 'Precompile assets only if any assets have changed.'
            task :lazy_precompile do
              current_revision        = "cat #{current_path}/REVISION"
              head_revision           = "cat #{latest_release}/REVISION"
              assets_paths            = ["#{latest_release}/app/assets/", "#{latest_release}/lib/assets/", "#{latest_release}/vendor/assets/"]
              precompilation_required = false

              assets_paths.each do |a|
                if capture("cd #{latest_release} && svn log -r $(#{current_revision}):$(#{head_revision}) #{a} | wc -l").to_i > 0
                  precompilation_required = true
                else
                  logger.info "Skipping pre-compilation for assets in #{a} because there were no asset changes."
                end
              end
              run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile" if precompilation_required
            end
          end
        end

        after 'deploy:update', 'deploy:assets:refresh_cache'

      end
    end
  end
end