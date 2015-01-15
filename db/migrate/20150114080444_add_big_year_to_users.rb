class AddBigYearToUsers < ActiveRecord::Migration
  def change
    add_column :users, :big_year, :boolean, default: true
  end
end
