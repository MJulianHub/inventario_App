class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true
      t.string :code
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :stock
      t.boolean :active

      t.timestamps
    end
  end
end
