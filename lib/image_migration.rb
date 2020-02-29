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

        new_file_name = filename(file_path)
        new_file_dir = store_dir(user, 'avatar')
        FileUtils.mkdir_p(File.dirname(new_file_dir))

        puts "******* Old file: #{file_path} - new: #{new_file_dir + '/' + new_file_name}"
        FileUtils.cp file_path, new_file_dir + '/' + new_file_name

        puts "******* Old thumb: #{thumb_file_path} - new: #{new_file_dir + '/thumb_' + new_file_name}"
        FileUtils.cp thumb_file_path, new_file_dir + '/thumb_' + new_file_name

        # sql = "update users set avatar = '#{new_file_name}' where id = #{user.id}"
        # ActiveRecord::Base.connection.execute sql
      rescue => e
        puts "ImageMigration#update_users_avatar failed with message = #{e.message}"
      end
    end
  end

  def filename(file_path)
    file_ext_with_dot = File.extname file_path
    "#{secure_token}#{file_ext_with_dot}"
  end

  def secure_token(length=16)
    SecureRandom.hex(length/2)
  end

  def store_dir(model, mounted_as)
    dir = "images/#{model.class.to_s.underscore}/#{mounted_as}/#{salted_reproducible_id(model.id)}"
    File.join(Rails.root, "public", dir)
  end

  def salted_reproducible_id(model_id)
    secret = [ENV['CARRIERWAVE_SALT'], model_id].join('/')
    Digest::SHA256.hexdigest(secret)
  end
end