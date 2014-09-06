class CreateBirds < ActiveRecord::Migration
  def change
    create_table :birds do |t|
      t.string :name_ru
      t.string :name_lat
      t.string :name_en
      t.integer :category_id
      t.text :description
      t.text :distribution
      t.text :biology
      t.text :reference

      t.timestamps
    end
  end
end
