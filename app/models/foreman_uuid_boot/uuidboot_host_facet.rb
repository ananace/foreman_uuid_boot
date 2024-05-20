# frozen_string_literal: true

module ForemanUuidBoot
  class UuidbootHostFacet < ApplicationRecord
    include Facets::Base

    UUID_REX = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/.freeze

    def self.populate_fields_from_facts(host, parser, _type, _proxy)
      uuid = parser.facts.dig('dmi', 'product', 'uuid') || parser.facts['uuid']

      if uuid && uuid =~ UUID_REX
        facet = host.uuidboot_facet || host.build_uuidboot_facet
        facet.uuid = uuid
        facet.save if facet.changed? || !facet.persisted?
        facet
      else
        host.uuidboot_facet&.destroy
        host.uuidboot_facet = nil
        nil
      end
    end
  end
end
