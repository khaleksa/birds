# encoding: UTF-8

Categories::Order.seed(:id,
  {:id => 1, :name_ru => "Гагарообразные", :name_en => "Gaviiformes", :name_lat => "Gaviiformes", :type => 'Categories::Order', :position => 1},
  {:id => 2, :name_ru => "Поганкообразные", :name_en => "Podicipediformes", :name_lat => "Podicipediformes",  :type => 'Categories::Order', :position => 2},
  {:id => 3, :name_ru => "Веслоногие", :name_en => "Pelecaniformes", :name_lat => "Pelecaniformes",  :type => 'Categories::Order', :position => 3}
)

Categories::Family.seed(:id,
  {:id => 4, :name_ru => "Гагаровые", :name_en => "Family Gaviidae", :name_lat => "Family Gaviidae", :type => 'Categories::Family', :parent_id => 1},
  {:id => 5, :name_ru => "Поганковые", :name_en => "Podicipedidae", :name_lat => "Podicipedidae", :type => 'Categories::Family', :parent_id => 2},
  {:id => 6, :name_ru => "Пеликановые", :name_en => "Pelecanidae", :name_lat => "Pelecanidae", :type => 'Categories::Family', :parent_id => 3}
)
