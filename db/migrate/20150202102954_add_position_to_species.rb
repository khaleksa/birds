class AddPositionToSpecies < ActiveRecord::Migration
  def change
    add_column :species, :position, :integer
  end
end
