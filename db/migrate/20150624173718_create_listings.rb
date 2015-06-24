class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.integer :category_id
      t.integer :wage

      t.timestamps null: false
    end
  end
end
