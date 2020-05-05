class RemoveTranslatedColumnsFromSpecies < ActiveRecord::Migration[5.1]
  def change
    remove_column :species, :name_ru, :string
    remove_column :species, :name_en, :string
    remove_column :species, :name_uz, :string
    remove_column :species, :description, :text
    remove_column :species, :description_uz, :text
    remove_column :species, :description_en, :text
    remove_column :species, :distribution, :text
    remove_column :species, :distribution_uz, :text
    remove_column :species, :distribution_en, :text
    remove_column :species, :biology, :text
    remove_column :species, :biology_uz, :text
    remove_column :species, :biology_en, :text
    remove_column :species, :reference, :text
    remove_column :species, :reference_uz, :text
    remove_column :species, :reference_en, :text
  end
end
