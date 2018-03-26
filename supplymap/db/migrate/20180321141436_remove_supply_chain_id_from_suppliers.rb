class RemoveSupplyChainIdFromSuppliers < ActiveRecord::Migration[5.1]
  def change
  	remove_reference :suppliers, :supply_chain, index:true, foreign_key: true
  end
end
