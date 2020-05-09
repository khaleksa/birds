class RemoveTranslatedColumnsFromCategories < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories, :name_ru, :string
    remove_column :categories, :name_en, :string
    remove_column :categories, :name_uz, :string
    remove_column :categories, :description, :text
  end
end