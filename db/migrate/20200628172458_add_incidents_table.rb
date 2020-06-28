# frozen_string_literal: true

class AddIncidentsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :incidents do |t|
      t.text :incident
      t.text :victim
      t.integer :amount, null: false, default: 0
      t.timestamps
    end
  end
end
