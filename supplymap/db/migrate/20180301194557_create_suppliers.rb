class CreateSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :type
      t.string :type
      t.text :description
      t.references :supply_chain, index: true, foreign_key: true
      t.decimal :lattitude
      t.decimal :longitude
      t.timestamps
    end
  end
end
