class CreateSupplyMaps < ActiveRecord::Migration[5.1]
  def change
    create_table :supply_maps do |t|
      t.string :name
      t.integer :supply_map_id

      t.timestamps
    end
  end
end
