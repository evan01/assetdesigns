class AddAttachedPictureToSupplier < ActiveRecord::Migration[5.1]
  def change
    add_attachment :suppliers, :image
  end
end
