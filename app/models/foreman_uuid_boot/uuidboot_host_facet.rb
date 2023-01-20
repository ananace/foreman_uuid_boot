# frozen_string_literal: true

module ForemanUuidBoot
  class UuidbootHostFacet < ApplicationRecord
    include Facets::Base

    def self.populate_fields_from_facts(host, parser, _type, _proxy)
      facet = host.uuidboot_facet || host.build_uuidboot_facet
      facet.uuid = parser.facts.dig('dmi', 'product', 'uuid') || parser.facts['uuid']
      facet.save if facet.changed?
    end
  end
end
