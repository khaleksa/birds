class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :type
      t.string :name_ru
      t.string :name_lat
      t.string :name_en
      t.text :description

      t.timestamps
    end
  end
end
