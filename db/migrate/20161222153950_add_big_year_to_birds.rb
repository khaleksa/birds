class AddBigYearToBirds < ActiveRecord::Migration[5.0]
  def change
    add_column :birds, :big_year, :integer, default: 0
  end
end
