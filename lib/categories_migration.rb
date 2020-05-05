class CategoriesMigration
  def self.migrate_ru
    sql = "
      insert into category_translations (category_id, locale, name, description, created_at, updated_at)
      select
        id, 'ru', name_ru, description, now(), now()
      from categories
    "
    prev_size = category_translations_size
    res = ActiveRecord::Base.connection.execute(sql)
    current_size = category_translations_size
    puts "*** RU Migration result: #{res.inspect}"
    puts "*** Before category_translations row count = #{prev_size}"
    puts "*** After category_translations row count = #{current_size}"
  end

  def self.migrate_en
    sql = "
      insert into category_translations (category_id, locale, name, description, created_at, updated_at)
      select
        id, 'en', name_en, null, now(), now()
      from categories
    "
    prev_size = category_translations_size
    res = ActiveRecord::Base.connection.execute(sql)
    current_size = category_translations_size
    puts "*** RU Migration result: #{res.inspect}"
    puts "*** Before category_translations row count = #{prev_size}"
    puts "*** After category_translations row count = #{current_size}"
  end

  def self.migrate_uz
    sql = "
      insert into category_translations (category_id, locale, name, description, created_at, updated_at)
      select
        id, 'uz', name_uz, null, now(), now()
      from categories
    "
    prev_size = category_translations_size
    res = ActiveRecord::Base.connection.execute(sql)
    current_size = category_translations_size
    puts "*** RU Migration result: #{res.inspect}"
    puts "*** Before category_translations row count = #{prev_size}"
    puts "*** After category_translations row count = #{current_size}"
  end
  
  def self.category_translations_size
    result = ActiveRecord::Base.connection.execute('select count(*) from category_translations')
    result.first['count']
  end
end