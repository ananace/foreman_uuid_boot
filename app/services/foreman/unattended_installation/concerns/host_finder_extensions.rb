# frozen_string_literal: true

module HostFinderExtensions
  def search
    host = super
    host ||= find_host_by_uuid unless token_from_params.present?

    host
  end

  private

  def find_host_by_uuid
    return unless (uuid = query_params['uuid'])

    facets = ForemanUuidBoot::UuidbootHostFacet.where(uuid: uuid).order(:created_at)
    if facets.any?
      Rails.logger.warn("Multiple hosts found with #{uuid}, picking up the most recent") if facets.count > 1

      return facets.last.host.reload
    end

    # Fallback fact search
    fact_name_id = FactName.where(name: 'uuid').map(&:id)
    return unless fact_name_id.any?

    query = { fact_values: { fact_name_id: fact_name_id, value: uuid } }
    hosts = Host.joins(:fact_values).where(query).order(:created_at)

    Rails.logger.warn("Multiple hosts found with #{uuid}, picking up the most recent") if hosts.count > 1

    return unless hosts.present?

    hosts.last.reload
  end
end
