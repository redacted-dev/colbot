class AddCutoffsAndTypeToIncidents < ActiveRecord::Migration[6.0]
  def change
    add_column :incidents, :type, :string
    add_column :incidents, :started_at, :string
    add_column :incidents, :ended_at, :string
    change_column_default :incidents, :type, 'daily'
  end
end
