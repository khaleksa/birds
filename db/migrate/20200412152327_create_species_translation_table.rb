class CreateSpeciesTranslationTable < ActiveRecord::Migration[5.1]
  def up
    Species.create_translation_table!({
      name: :string,
      descriptions: :text ,
      biology: :text,
      reference: :text
    })
  end
  
  def down
    Species.drop_translation_table!
  end
end
