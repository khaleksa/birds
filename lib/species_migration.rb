class SpeciesMigration
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