# frozen_string_literal: true

class FixIncidentsCutoffs < ActiveRecord::Migration[6.0]
  def change
    remove_column :incidents, :started_at
    remove_column :incidents, :ended_at
    add_column :incidents, :started_at, :datetime
    add_column :incidents, :ended_at, :datetime
  end
end
