module PagesHelper

  def member_column_count(total_count)
    (total_count < 3) ? total_count : 3
  end
end
