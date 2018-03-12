class FixColumnsInSupplierConnections < ActiveRecord::Migration[5.1]
  def change
  	rename_column :supplier_connections, :supplier_a, :supplier_a_id
  	rename_column :supplier_connections, :supplier_b, :supplier_b_id
  end
end
