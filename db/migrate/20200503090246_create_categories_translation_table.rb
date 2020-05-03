class CreateCategoriesTranslationTable < ActiveRecord::Migration[5.1]
  def up
    Categories::Category.create_translation_table!({
      name: :string,
      description: :text
    })
  end
  
  def down
    Categories::Category.drop_translation_table!
  end
end
