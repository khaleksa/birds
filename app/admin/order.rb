ActiveAdmin.register Categories::Order do
  permit_params :name_ru, :name_en, :name_lat, :name_uz,
                :description_ru, :description_uz, :description_en,
                :image, :position

  menu priority: 1

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

  show do |order|
    attributes_table do
      row :id
      row :position
      row :name_ru
      row :name_lat
      row :name_en
      row :name_uz
      row :description_ru
      row :description_en
      row :description_uz
      row :children do # TODO: check it
        order.families.each do |family|
          link_to family.parent.full_name, admin_categories_family_path(family.id)
        end
      end
      row :image do
        div do
          image_tag(order.image.url)
        end
      end if order.image.present?
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :position

      f.inputs 'Наименование' do
        f.input :name_ru
        f.input :name_lat
        f.input :name_en
        f.input :name_uz
      end

      f.inputs 'Описание' do
        f.input :description_ru
        f.input :description_uz
        f.input :description_en
      end
    end

    f.inputs do
      hint_image = f.object.image.present? ? f.template.image_tag(f.object.image.url) : ''
      f.input :image, :hint => hint_image
    end

    f.actions
  end
end
