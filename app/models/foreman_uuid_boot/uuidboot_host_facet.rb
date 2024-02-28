# frozen_string_literal: true

module ForemanUuidBoot
  class UuidbootHostFacet < ApplicationRecord
    include Facets::Base

    def self.populate_fields_from_facts(host, parser, _type, _proxy)
      uuid = parser.facts.dig('dmi', 'product', 'uuid') || parser.facts['uuid']

      if uuid
        facet = host.uuidboot_facet || host.build_uuidboot_facet
        facet.uuid = uuid
        facet.save if facet.changed? || !facet.persisted?
        facet
      else
        host.uuidboot_facet&.destroy
        nil
      end
    end
  end
end
