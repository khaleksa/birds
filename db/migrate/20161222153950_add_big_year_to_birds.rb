class AddBigYearToBirds < ActiveRecord::Migration
  def change
    add_column :birds, :big_year, :integer, default: 0
  end
end
