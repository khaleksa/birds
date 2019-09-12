class AddCategoryIndexToSpecies < ActiveRecord::Migration[5.0]
  def change
    add_index :species, :category_id
  end
end
