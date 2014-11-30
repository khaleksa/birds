ActiveAdmin.register Species do
  permit_params :name_ru, :name_en, :name_lat,
                :description, :distribution, :biology, :reference,
                :category_id, images_attributes: [:id, :image, :_destroy]

  filter :family
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

  show do |species|
    attributes_table do
      row :id
      row 'Семейство' do
        species.family.full_name
      end
      row :name_ru
      row :name_lat
      row :name_en
      row :description
      row :distribution
      row :biology
      row :reference
      row :created_at
      row :updated_at
      row :image do
        species.images.each do |i|
          div do
            image_tag(i.image.url)
          end
        end
      end
    end
  end

  form do |f|
    f.inputs 'Семейство' do
      f.input :family, as: :select, collection: Categories::Category.families
    end

    f.inputs do
      f.input :name_ru
      f.input :name_lat
      f.input :name_en
      f.input :description
      f.input :distribution
      f.input :biology
      f.input :reference
      f.input :image, :as => :file, :hint => f.template.image_tag(f.object.image.thumb.url)
    end

    f.inputs do
      f.has_many :images, :allow_destroy => true, :heading => 'Images' do |cf|
        cf.input :image, :hint => f.template.image_tag(cf.object.image.thumb.url)
      end
    end

    f.actions
  end
end
