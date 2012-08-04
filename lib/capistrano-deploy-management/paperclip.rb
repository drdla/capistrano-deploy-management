module CapistranoDeployManagement
  module Paperclip
    def self.load_into(configuration)
      configuration.load do

        namespace :paperclip do
          desc 'Build missing paperclip styles.'
          task :build_missing_paperclip_styles, roles: :app do
            run "cd #{current_path}; RAILS_ENV=production bundle exec rake paperclip:refresh:missing_styles"
          end
        end

      end
    end
  end
end