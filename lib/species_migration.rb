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
  
  def self.migrate_ru
    sql = "
      insert into species_translations (species_id, locale, name, description, distribution, biology, reference, created_at, updated_at)
      select
        id, 'ru', name_ru, description, distribution, biology, reference, now(), now()
      from species
    "
    prev_size = species_translations_size
    res = ActiveRecord::Base.connection.execute(sql)
    current_size = species_translations_size
    puts "*** RU Migration result: #{res.inspect}"
    puts "*** Before species_translations row count = #{prev_size}"
    puts "*** After species_translations row count = #{current_size}"
  end

  def self.migrate_en
    sql = "
      insert into species_translations (species_id, locale, name, description, distribution, biology, reference, created_at, updated_at)
      select
        id, 'en', name_en, description_en, distribution_en, biology_en, reference_en, now(), now()
      from species
    "
    prev_size = species_translations_size
    res = ActiveRecord::Base.connection.execute(sql)
    current_size = species_translations_size
    puts "*** EN Migration result: #{res.inspect}"
    puts "*** Before species_translations row count = #{prev_size}"
    puts "*** After species_translations row count = #{current_size}"
  end

  def self.migrate_uz
    sql = "
      insert into species_translations (species_id, locale, name, description, distribution, biology, reference, created_at, updated_at)
      select
        id, 'uz', name_uz, description_uz, distribution_uz, biology_uz, reference_uz, now(), now()
      from species
    "
    prev_size = species_translations_size
    res = ActiveRecord::Base.connection.execute(sql)
    current_size = species_translations_size
    puts "*** UZ Migration result: #{res.inspect}"
    puts "*** Before species_translations row count = #{prev_size}"
    puts "*** After species_translations row count = #{current_size}"
  end
  
  def self.species_translations_size
    result = ActiveRecord::Base.connection.execute('select count(*) from species_translations')
    result.first['count']
  end
  
  def self.destoy_all_species_translations
    result = ActiveRecord::Base.connection.execute('delete from species_translations where id > 0')
    puts "*** destoy_all_species_translations result: #{result.inspect}"
  end
end