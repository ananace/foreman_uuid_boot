# frozen_string_literal: true

module ForemanUuidBoot
  module HostDiscoveredExtensions
    def populate_fields_from_facts(parser, type, source_proxy)
      super
      populate_facet_fields(parser, type, source_proxy)
    end
  end
end
