# encoding: UTF-8

Categories::Order.seed(:id,
  {:id => 1, :name_ru => "Гагарообразные", :type => 'Categories::Order'},
  {:id => 2, :name_ru => "Поганкообразные", :type => 'Categories::Order'},
  {:id => 3, :name_ru => "Веслоногие", :type => 'Categories::Order'}
)

Categories::Family.seed(:id,
  {:id => 4, :name_ru => "Гагаровые", :type => 'Categories::Family', :parent_id => 1},
  {:id => 5, :name_ru => "Поганковые", :type => 'Categories::Family', :parent_id => 2},
  {:id => 6, :name_ru => "Пеликановые", :type => 'Categories::Family', :parent_id => 3}
)
