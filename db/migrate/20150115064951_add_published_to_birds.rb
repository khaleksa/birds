class AddPublishedToBirds < ActiveRecord::Migration
  def change
    add_column :birds, :published, :boolean, default: false
  end
end
