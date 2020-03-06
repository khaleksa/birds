class ImageMigration
  def update_users_avatar
    users = User.where.not(avatar: nil)
    puts "******* Count of users with avatar = #{users.count}"

    users.each do |user|
      begin
        puts "******* User id=#{user.id}"
        uploader =  user.avatar
        file_path = File.realdirpath(uploader.file.file)
        thumb_file_path = File.realdirpath(user.avatar.versions[:thumb].file.file)

        new_file_dir = store_dir_user(file_path, user, 'avatar')
        FileUtils.mkdir_p new_file_dir

        new_file_name = filename(file_path)
        puts "******* Old file: #{file_path} - new: #{new_file_dir + '/' + new_file_name}"
        FileUtils.cp file_path, new_file_dir + '/' + new_file_name

        puts "******* Old thumb: #{thumb_file_path} - new: #{new_file_dir + '/thumb_' + new_file_name}"
        FileUtils.cp thumb_file_path, new_file_dir + '/thumb_' + new_file_name

        sql = "update users set avatar = '#{new_file_name}' where id = #{user.id}"
        ActiveRecord::Base.connection.execute sql
      rescue => e
        puts "ImageMigration#update_users_avatar failed with message = #{e.message}"
      end
    end
  end

  def update_orders_image
    categories = Categories::Order.where.not(image: nil)
    puts "******* Count of categories with image = #{categories.count}"

    categories.each do |category|
      begin
        puts "******* Category id=#{category.id}"
        uploader =  category.image
        file_path = File.realdirpath(uploader.file.file)

        new_file_dir = store_dir_order(file_path, category, 'image')
        FileUtils.mkdir_p new_file_dir

        new_file_name = filename(file_path)
        puts "******* Old file: #{file_path} - new: #{new_file_dir + '/' + new_file_name}"
        FileUtils.cp file_path, new_file_dir + '/' + new_file_name

        sql = "update categories set image = '#{new_file_name}' where id = #{category.id}"
        ActiveRecord::Base.connection.execute sql
        puts "******* Category id=#{category.id} - SUCCESS!"
      rescue => e
        puts "ImageMigration#update_categories_image failed with message = #{e.message}"
      end
    end
  end

  def update_species_image
    images = Image.where.not(image: nil)
    puts "******* Count of species images = #{images.count}"

    images.each do |image|
      begin
        puts "******* Image id=#{image.id}"
        uploader =  image.image
        file_path = File.realdirpath(uploader.file.file)
        small_file_path = File.realdirpath(uploader.versions[:small].file.file)
        thumb_file_path = File.realdirpath(uploader.versions[:thumb].file.file)

        new_file_dir = store_dir_species(file_path, image)
        FileUtils.mkdir_p new_file_dir

        new_file_name = filename(file_path)
        puts "******* Old file: #{file_path} - new: #{new_file_dir + '/' + new_file_name}"
        FileUtils.cp file_path, new_file_dir + '/' + new_file_name

        puts "******* Old small: #{small_file_path} - new: #{new_file_dir + '/small_' + new_file_name}"
        FileUtils.cp small_file_path, new_file_dir + '/small_' + new_file_name

        puts "******* Old thumb: #{thumb_file_path} - new: #{new_file_dir + '/thumb_' + new_file_name}"
        FileUtils.cp thumb_file_path, new_file_dir + '/thumb_' + new_file_name

        sql = "update images set image = '#{new_file_name}' where id = #{image.id}"
        ActiveRecord::Base.connection.execute sql
      rescue => e
        puts "ImageMigration#update_species_image failed with message = #{e.message}"
      end
    end
  end

  def update_birds_photo
    birds = Bird.where.not(photo: nil)
    puts "******* Count of bird photos = #{birds.count}"

    birds.each do |bird|
      begin
        puts "******* Image id=#{bird.id}"
        uploader =  bird.photo
        file_path = File.realdirpath(uploader.file.file)
        small_file_path = File.realdirpath(uploader.versions[:small].file.file)
        thumb_file_path = File.realdirpath(uploader.versions[:thumb].file.file)

        new_file_dir = store_dir_bird(file_path, bird, 'photo')
        FileUtils.mkdir_p new_file_dir

        new_file_name = filename(file_path)
        FileUtils.cp file_path, new_file_dir + '/' + new_file_name
        puts "******* Old file: #{file_path} - new: #{new_file_dir + '/' + new_file_name}"

        FileUtils.cp small_file_path, new_file_dir + '/small_' + new_file_name
        puts "******* Old small: #{small_file_path} - new: #{new_file_dir + '/small_' + new_file_name}"

        FileUtils.cp thumb_file_path, new_file_dir + '/thumb_' + new_file_name
        puts "******* Old thumb: #{thumb_file_path} - new: #{new_file_dir + '/thumb_' + new_file_name}"

        sql = "update birds set photo = '#{new_file_name}' where id = #{bird.id}"
        ActiveRecord::Base.connection.execute sql
      rescue => e
        puts "ImageMigration#update_birds_photo failed with message = #{e.message}"
      end
    end
  end

  private

  def filename(file_path)
    file_ext_with_dot = File.extname file_path
    "#{secure_token}#{file_ext_with_dot}"
  end

  def secure_token(length=16)
    SecureRandom.hex(length/2)
  end

  def store_dir_species(file_path, model)
    base_path = file_path.gsub(/uploads\/image\/image(.)*/, '')
    base_path + "images/species/image/#{salted_reproducible_id(model.id)}"
  end

  def store_dir_order(file_path, model, mounted_as)
    base_path = file_path.gsub(/uploads\/categories\/order(.)*/, '')
    base_path + "images/#{model.class.to_s.underscore}/#{mounted_as}/#{salted_reproducible_id(model.id)}"
  end

  def store_dir_user(file_path, model, mounted_as)
    base_path = file_path.gsub(/uploads\/user\/avatar(.)*/, '')
    base_path + "images/#{model.class.to_s.underscore}/#{mounted_as}/#{salted_reproducible_id(model.id)}"
  end

  def store_dir_bird(file_path, model, mounted_as)
    base_path = file_path.gsub(/uploads\/bird\/photo(.)*/, '')
    base_path + "images/#{model.class.to_s.underscore}/#{mounted_as}/#{salted_reproducible_id(model.id)}"
  end

  def salted_reproducible_id(model_id)
    secret = [ENV['BIRDS_CARRIERWAVE_SALT'], model_id].join('/')
    Digest::SHA256.hexdigest(secret)
  end
end