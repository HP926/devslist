class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :for_sale
      t.string :jobs
    end
  end
end
