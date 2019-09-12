class AddPublishedToBirds < ActiveRecord::Migration[5.0]
  def change
    add_column :birds, :published, :boolean, default: false
  end
end
