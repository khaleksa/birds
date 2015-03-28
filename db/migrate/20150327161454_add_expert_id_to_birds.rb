class AddExpertIdToBirds < ActiveRecord::Migration
  def change
    add_column :birds, :expert_id, :integer
  end
end
