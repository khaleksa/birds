class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.integer :year
      t.timestamps
    end

    add_index(:subscriptions, [:user_id, :year], unique: true)
  end
end
