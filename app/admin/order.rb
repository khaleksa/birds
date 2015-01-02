ActiveAdmin.register Categories::Order do
  permit_params :name_ru, :name_en, :name_lat, :description

  menu priority: 1

  filter :name_ru
  filter :name_lat
  filter :name_en

  index do
    column :id
    column :name_ru
    column :name_lat
    column :name_en
    actions
  end

  show do
    attributes_table do
      row :id
      row :name_ru
      row :name_lat
      row :name_en
      row :description
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name_ru
      f.input :name_lat
      f.input :name_en
      f.input :description
    end

    f.actions
  end
end
