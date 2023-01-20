# frozen_string_literal: true

module ForemanUuidBoot
  class Engine < ::Rails::Engine
    engine_name 'foreman_uuid_boot'

    config.autoload_paths += Dir["#{config.root}/app/services/foreman/unattended_installation/concerns"]

    initializer 'foreman_uuid_boot.load_app_instance_data' do |app|
      ForemanUuidBoot::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_uuid_boot.register_plugin', before: :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_uuid_boot do
        requires_foreman '>= 2.5'

        register_facet ForemanUuidBoot::UuidbootHostFacet, :uuidboot_facet do
          set_dependent_action :destroy
        end
      end
    end

    config.to_prepare do
      ::Foreman::UnattendedInstallation::HostFinder.prepend ForemanUuidBoot::HostFinderExtensions
    rescue StandardError => e
      Rails.logger.warn "ForemanUuidBoot: skipping engine hook(#{e})"
    end
  end
end
