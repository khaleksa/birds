class SetDefaultPosition < ActiveRecord::Migration
  def change
    change_column :species, :position, :integer, :default => 0
    change_column :categories, :position, :integer, :default => 0
  end
end
