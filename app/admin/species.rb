ActiveAdmin.register Species do
  permit_params :name_ru, :name_en, :name_lat, :name_uz,
                :description, :distribution, :biology, :reference,
                :category_id, :status, :show_map, :position, :parent_id, :single_subspecies,
                images_attributes: [:id, :image, :_destroy, :description, :author, :date, :address, :default]

  menu priority: 3

  filter :family
  filter :name_ru
  filter :name_lat
  filter :name_en

  index do
    column :id
    column :position
    column :name_ru
    column :name_lat
    column :name_en
    column 'Родительский вид' do |species|
      link_to(species.parent.try(:name_lat), admin_species_path(species.parent)) if species.parent.present?
    end
    actions
  end

  show do |species|
    div do
      link_to 'Как это выглядит на birds.uz', species_path(species.id)
    end

    attributes_table do
      row 'Семейство' do
        link_to species.family.full_name, admin_categories_family_path(species.family.id)
      end
      row :position
      row :parent do
        link_to(species.parent.name_lat, admin_species_path(species.parent.id)) if species.parent.present?
      end
      row :children do
        species.sub_species.each do |ss|
          div do
            link_to ss.name_ru, admin_species_path(ss.id)
          end
        end
      end
      row :name_ru
      row :name_lat
      row :name_en
      row :name_uz
      row :status
      row :description
      row :distribution
      row :biology
      row :reference
      row :single_subspecies
      row :show_map
      row :created_at
      row :updated_at
      row :images do
        species.images.each do |i|
          div do
            image_tag(i.image.thumb.url)
          end
        end
      end
    end
  end

  form do |f|
    f.inputs 'Классификация' do
      f.input :family, as: :select, collection: Categories::Category.families
      f.input :position
      f.input :parent
    end

    f.inputs 'Описание вида' do
      f.input :name_ru
      f.input :name_lat
      f.input :name_en
      f.input :name_uz
      f.input :status
      f.input :description
      f.input :distribution
      f.input :biology
      f.input :reference
      f.input :single_subspecies
      f.input :show_map
    end

    f.inputs 'Фото' do
      f.has_many :images, :allow_destroy => true, :heading => 'Images' do |cf|
        cf.input :image, :hint => f.template.image_tag(cf.object.image.thumb.url)
        cf.input :date, :as => :datepicker
        cf.input :description
        cf.input :author
        cf.input :address
        cf.input :default
      end
    end if f.object.persisted?

    f.actions
  end
end
