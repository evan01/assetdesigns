class RemoveAddSupplierColumns < ActiveRecord::Migration[5.1]
  def change
      remove_column :suppliers, :supplier_id
      add_column :suppliers, :description, :string
  end
end
