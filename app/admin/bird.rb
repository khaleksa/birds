ActiveAdmin.register Bird do
  permit_params :timestamp, :species_id, :user_id, :latitude, :longitude, :address, :photo, :published

  menu priority: 4

  filter :species
  filter :user

  index do
    column :timestamp
    column :species do |bird|
      link_to(bird.species.name_ru, admin_species_path(bird.species)) if bird.species.present?
    end
    column :user
    column :published
    actions
  end

  show do |bird|
    attributes_table do
      row :id
      row :timestamp
      row :species
      row :user
      row :latitude
      row :longitude
      row :address
      row :photo do
        div do
          image_tag(bird.photo.thumb.url)
        end
      end
      row :published
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :timestamp, as: :datepicker
      f.input :species
      f.input :user
      f.input :latitude
      f.input :longitude
      f.input :address
      f.input :published
    end
    f.inputs do
      f.input :photo, :hint => f.template.image_tag(f.object.photo.url)
    end

    f.actions
  end
end
