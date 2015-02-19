class AddNameUzToSpecies < ActiveRecord::Migration
  def change
    add_column :species, :name_uz, :string
    add_column :species, :single_subspecies, :boolean, default: false
    add_column :categories, :name_uz, :string
  end
end
