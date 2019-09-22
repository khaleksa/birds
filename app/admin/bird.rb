ActiveAdmin.register Bird do
  permit_params :timestamp, :species_id, :user_id, :latitude, :longitude, :address, :photo, :published

  menu priority: 4

  filter :id
  filter :species, :collection => proc { Species.order(:name_ru) }, :label => 'Вид'
  filter :user, :collection => proc { User.order(:last_name) }, :label => 'Бёрдвотчеров'

  index do
    column :id
    column 'Дата создания' do |bird|
      bird.created_at.strftime('%d-%m-%Y %H:%M')
    end
    column 'Дата встречи', :timestamp
    column :species do |bird|
      link_to(bird.species.name_ru, admin_species_path(bird.species)) if bird.species.present?
    end
    column :user
    column 'P', :published
    actions
  end

  show do |bird|
    attributes_table do
      row :id
      row :timestamp
      row :species
      row :user
      row :expert do
        link_to bird.expert.full_name, profile_path(bird.expert) if bird.expert.present?
      end
      row :latitude
      row :longitude
      row :address
      row :photo do
        div do
          image_tag(bird.photo.thumb.url)
        end
      end if bird.photo.present?
      row :published
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :timestamp, as: :datepicker
      f.input :species, as: :select, collection: Species.all.order(:name_ru)
      f.input :user, as: :select, collection: User.all.order(:last_name)
      f.input :latitude
      f.input :longitude
      f.input :address
      f.input :published
    end
    f.inputs do
      f.input :photo, :hint => ( f.object.photo.present? ? f.template.image_tag(f.object.photo.url) : '')
    end

    f.actions
  end
end
