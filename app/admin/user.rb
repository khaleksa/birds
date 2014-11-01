ActiveAdmin.register User do
  actions :all, :except => [:destroy, :edit]
  filter :email

  index do
    column :id
    column :email
    column :first_name
    column :last_name
    column :sign_in_count
    column :last_sign_in_at
    column :created_at
    column :updated_at
    actions
  end
end
