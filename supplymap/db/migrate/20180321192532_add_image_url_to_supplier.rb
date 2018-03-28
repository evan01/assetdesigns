class AddImageUrlToSupplier < ActiveRecord::Migration[5.1]
  def change
    add_column :suppliers, :image_url, :string
  end
end
