class AddParentIdToSpecies < ActiveRecord::Migration
  def change
    add_column :species, :parent_id, :integer
    add_index :species, :parent_id
  end
end
