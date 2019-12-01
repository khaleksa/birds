class AddEnglishFieldsToSpecies < ActiveRecord::Migration[5.1]
  def change
    add_column :species, :description_en, :text, nil: true
    add_column :species, :distribution_en, :text, nil: true
    add_column :species, :biology_en, :text, nil: true
    add_column :species, :reference_en, :text, nil: true
  end
end

