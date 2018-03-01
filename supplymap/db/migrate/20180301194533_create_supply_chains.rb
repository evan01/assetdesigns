class CreateSupplyChains < ActiveRecord::Migration[5.1]
  def change
    create_table :supply_chains do |t|
      t.string :name
      t.text :description
      t.integer :count
      t.timestamps
    end
  end
end
