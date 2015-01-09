class CreateBirds < ActiveRecord::Migration
  def change
    create_table :birds do |t|
      t.datetime :timestamp
      t.references :species, index: true
      t.references :user, index: true
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.text :address
      t.string :photo

      t.timestamps
    end
  end
end
