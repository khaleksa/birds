class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :image
      t.references :species, index: true, null: false
    end
  end
end
