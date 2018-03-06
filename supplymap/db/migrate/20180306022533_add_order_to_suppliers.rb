class AddOrderToSuppliers < ActiveRecord::Migration[5.1]
  def change
    add_column :suppliers, :order, :integer
  end
end
