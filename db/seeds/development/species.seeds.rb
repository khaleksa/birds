# encoding: UTF-8

Species.seed(:id,
  {:id => 1, :name_ru => "Чернозобая гагара", :name_lat => 'Gavia arctica', :name_en => 'Arctic Loon', :category_id => 4},
  {:id => 2, :name_ru => "Малая поганка", :name_lat => 'Tachybaptus ruficollis', :name_en => 'Little Grebe', :category_id => 5},
  {:id => 3, :name_ru => "Чомга", :name_lat => 'Podiceps cristatus', :name_en => 'Great Crested Grebe', :category_id => 6},
  {:id => 4, :name_ru => "Деревенская ласточка", :name_lat => 'Hirundo rustica', :name_en => 'Barn Swallow', :category_id => 6},
  {:id => 5, :name_ru => "Деревенская ласточка", :name_lat => 'Hirundo rustica rustica', :name_en => 'Barn Swallow', :category_id => 6, :parent_id => 4},
  {:id => 6, :name_ru => "Деревенская ласточка", :name_lat => 'Hirundo rustica tytleri', :name_en => 'Barn Swallow', :category_id => 6, :parent_id => 4}
)
