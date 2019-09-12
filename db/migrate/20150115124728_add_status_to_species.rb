class AddStatusToSpecies < ActiveRecord::Migration[5.0]
  def change
    add_column :species, :status, :string
    add_column :species, :show_map, :boolean, default: true
  end
end
