class FixIncidentsType < ActiveRecord::Migration[6.0]
  def change
    remove_column :incidents, :type
    add_column :incidents, :category, :string
  end
end
