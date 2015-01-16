class AddStatusToSpecies < ActiveRecord::Migration
  def change
    add_column :species, :status, :string
    add_column :species, :show_map, :boolean, default: true
  end
end
