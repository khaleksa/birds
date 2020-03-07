# encoding: utf-8

class CategoryUploader < BaseUploader
  process :resize_to_fit => [100, 200]

end
