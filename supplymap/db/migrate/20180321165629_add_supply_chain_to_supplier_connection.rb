class AddSupplyChainToSupplierConnection < ActiveRecord::Migration[5.1]
  def change
    add_reference :supplier_connections, :supply_chain, foreign_key: true
  end
end
