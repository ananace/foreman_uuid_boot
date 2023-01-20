# frozen_string_literal: true

class AddUuidbootFacet < ActiveRecord::Migration[5.1]
  def change
    create_table :uuidboot_host_facets do |t|
      t.references :host, type: :integer, foreign_key: true, index: { unique: true }
      t.uuid :uuid, null: false

      t.timestamps
    end
  end
end
