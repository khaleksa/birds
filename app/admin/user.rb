ActiveAdmin.register User do
  actions :all, :except => [:destroy, :edit]
  menu priority: 5
  filter :email

  index do
    column :id
    column :email
    column :first_name
    column :last_name
    column :created_at
    actions
  end

  show do |user|
    attributes_table do
      row :id
      row :email
      row :first_name
      row :last_name
      row :roles do |user|
        user.roles.map(&:name).each do |role|
          status_tag role, role == 'admin' ? :red : :green
        end
      end
      row :sign_in_count
      row :last_sign_in_at
      row :updated_at
      row :created_at
    end
  end

end
