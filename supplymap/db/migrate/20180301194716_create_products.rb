class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :type
      t.text :description
      t.references :supply_chain, index: true, foreign_key: true
      t.timestamps
    end
  end
end
