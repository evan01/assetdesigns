class AddColumnsToConnections < ActiveRecord::Migration[5.1]
  def change
    add_column :suppliers, :image_url, :string
    add_column :connections, :order_in_chain, :integer
    add_column :connections, :supplier_connected_to, :integer
    add_column :connections, :supply_chain_id, :integer
    add_column :connections, :co2_emission, :integer
    add_column :connections, :transportation, :string

    create_table :supply_chains do |t|
      t.string :name
      t.text :description
      t.integer :supply_chain_id
      t.timestamps
    end

    drop_table :supply_maps
  end
end
