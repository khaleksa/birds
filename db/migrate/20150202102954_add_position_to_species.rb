class AddPositionToSpecies < ActiveRecord::Migration[5.0]
  def change
    add_column :species, :position, :integer
  end
end
