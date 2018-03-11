class CreateSupplierConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :supplier_connections do |t|
    	t.integer :supplier_a, :null => false
    	t.integer :supplier_b, :null => false
    	t.decimal :co2_emission
    	t.decimal :distance
    end
  end
end
