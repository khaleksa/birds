class AddUzbekFieldsToSpecies < ActiveRecord::Migration[5.1]
  def change
    add_column :species, :description_uz, :text, nil: true
    add_column :species, :distribution_uz, :text, nil: true
    add_column :species, :biology_uz, :text, nil: true
    add_column :species, :reference_uz, :text, nil: true
  end
end
