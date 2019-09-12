class AddExpertIdToBirds < ActiveRecord::Migration[5.0]
  def change
    add_column :birds, :expert_id, :integer
  end
end
