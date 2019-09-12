class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles, :force => true do |t|
      t.string :name
    end

    create_table "roles_users", :force => true do |t|
      t.integer "role_id"
      t.integer "user_id"
    end

    add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
    add_index "roles_users", ["user_id", "role_id"], :name => "index_roles_users_on_user_id_and_role_id", :unique => true
    add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"
  end

end
