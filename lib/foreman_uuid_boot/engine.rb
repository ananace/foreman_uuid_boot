# frozen_string_literal: true

module ForemanUuidBoot
  class Engine < ::Rails::Engine
    engine_name 'foreman_uuid_boot'

    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/services/foreman/unattended_installation/concerns"]

    initializer 'foreman_uuid_boot.load_app_instance_data' do |app|
      ForemanUuidBoot::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_uuid_boot.register_plugin', before: :finisher_hook do |app|
      app.reloader.to_prepare do
        Foreman::Plugin.register :foreman_uuid_boot do
          requires_foreman '>= 3.12'

          register_facet ForemanUuidBoot::UuidbootHostFacet, :uuidboot_facet do
            configure_host do
              set_dependent_action :destroy
            end
          end
        end
      end
    end

    config.to_prepare do
      ::Foreman::UnattendedInstallation::HostFinder.prepend ForemanUuidBoot::HostFinderExtensions

      if Foreman::Plugin.installed?('foreman_discovery')
        # Slight hack for foreman_discovery - to store UUID for provision
        begin
          # Ensure that Host::Discovered applies host facets
          unless ::Host::Discovered.include? Facets::ModelExtensionsBase
            ::Host::Discovered.include SelectiveClone
            ::Host::Discovered.include Facets::ManagedHostExtensions
            ::Host::Discovered.prepend ForemanUuidBoot::HostDiscoveredExtensions

            Rails.logger.info 'ForemanUuidBoot: Extended foreman_discovery with facet support'
          end
        rescue StandardError => e
          Rails.logger.warn "ForemanUuidBoot: Failed to activate discovery extensions (#{e})"
        end
      end
    rescue StandardError => e
      Rails.logger.warn "ForemanUuidBoot: skipping engine hook(#{e})"
    end
  end
end
