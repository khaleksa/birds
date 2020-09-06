ActiveAdmin.register Categories::Family do
  permit_params :name_ru, :name_en, :name_lat, :name_uz,
                :description_ru, :description_uz, :description_en,
                :parent_id, :position

  menu priority: 2

  filter :parent,  :collection => proc { Categories::Category.orders }, :label => 'Отряд'
  filter :name_ru
  filter :name_lat
  filter :name_en

  index do
    column :id
    column :position
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
      row :position
      row :name_ru
      row :name_lat
      row :name_en
      row :name_uz
      row :description_ru
      row :description_uz
      row :description_en
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs 'Отряд' do
      f.input :parent, as: :select, collection: Categories::Category.orders
      f.input :position
    end

    f.inputs do
      f.inputs 'Наименование' do
        f.input :name_ru
        f.input :name_lat
        f.input :name_en
        f.input :name_uz
      end

      f.inputs 'Описание' do
        f.input :description_ru, as: :text
        f.input :description_en, as: :text
        f.input :description_uz, as: :text
      end
    end

    f.actions
  end
end
