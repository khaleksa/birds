class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :bird, index: true
      t.references :user, index: true
      t.text :text

      t.timestamps
    end
  end
end
