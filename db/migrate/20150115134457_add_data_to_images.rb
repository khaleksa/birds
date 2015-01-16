class AddDataToImages < ActiveRecord::Migration
  def change
    add_column :images, :description, :string
    add_column :images, :author, :string
    add_column :images, :date, :date
    add_column :images, :address, :string
    add_column :images, :default, :boolean, default: false
  end
end
