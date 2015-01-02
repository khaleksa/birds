ActiveAdmin.register Categories::Family do
  permit_params :name_ru, :name_en, :name_lat, :description, :parent_id

  menu priority: 2

  filter :parent,  :collection => proc { Categories::Category.orders }, :label => 'Отряд'
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

  show do |family|
    attributes_table do
      row :id
      row 'Отряд' do
        link_to family.parent.full_name, admin_categories_order_path(family.order)
      end
      row :name_ru
      row :name_lat
      row :name_en
      row :description
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs 'Отряд' do
      f.input :parent, as: :select, collection: Categories::Category.orders
    end

    f.inputs do
      f.input :name_ru
      f.input :name_lat
      f.input :name_en
      f.input :description
    end

    f.actions
  end
end
