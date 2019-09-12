class AddBigYearToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :big_year, :boolean, default: true
  end
end
