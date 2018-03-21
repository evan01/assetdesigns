class CreateJoinTableSupplyChainsSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :supply_chains, :suppliers do |t|
      t.references :supply_chain, foreign_key: true
      # t.index [:supplier_id, :supply_chain_id]
    end
  end
end
