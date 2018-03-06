class FixTypeColumnInSuppliers < ActiveRecord::Migration[5.1]
  def change
    rename_column :suppliers, :type, :product_kind
  end
end
