class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :make
      t.references :product_type, foreign_key: {to_table: :master_types}
      t.timestamps
    end
  end
end
