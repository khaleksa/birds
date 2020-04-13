class SpeciesMigration
  def self.migrate
    sql = '
      select id,
        name_ru, name_en, name_uz,
        description, description_en, description_uz,
        distribution, distribution_en, distribution_uz,
        biology, biology_en, biology_uz,
        reference, reference_en, reference_uz
      from species
    '
    raws = ActiveRecord::Base.connection.execute(sql)
    
    raws.each do |raw|
      sql_insert = "
        insert into species_translations (species_id, locale, name, description, distribution, biology, reference, created_at, updated_at)
        values
          (#{raw['id']}, 'ru', '#{raw['name_ru']}', '#{raw['description']}', '#{raw['distribution']}', '#{raw['biology']}', '#{raw['reference']}', now(), now()),
          (#{raw['id']}, 'en', '#{raw['name_en']}', '#{raw['description_en']}', '#{raw['distribution_en']}', '#{raw['biology_en']}', '#{raw['reference_en']}', now(), now()),
          (#{raw['id']}, 'uz', '#{raw['name_uz']}', '#{raw['description_uz']}', '#{raw['distribution_uz']}', '#{raw['biology_uz']}', '#{raw['reference_uz']}', now(), now())
        "
      puts sql_insert
      ActiveRecord::Base.connection.execute(sql_insert)
    end
  end
end