ActiveAdmin.register Family do
  filter :name_ru
  filter :name_lat
  filter :name_en

  index do
    column :id
    column :name_ru
    column :name_lat
    column :name_en
    column :created_at
    column :updated_at
    actions
  end
end
