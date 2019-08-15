# frozen_string_literal: true

class CreateExchangeRates < ActiveRecord::Migration[6.0]
  def change
    create_table :exchange_rates do |t|
      t.integer :amount, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end
