class CreateExchangeRates < ActiveRecord::Migration[6.0]
  def change
    create_table :exchange_rates do |t|
      t.integer :amount
      t.string :category

      t.timestamps
    end
  end
end
