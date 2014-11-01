# encoding: UTF-8

Order.seed(:id,
  {:id => 1, :name_ru => "Гагарообразные", :type => 'Order'},
  {:id => 2, :name_ru => "Поганкообразные", :type => 'Order'},
  {:id => 3, :name_ru => "Веслоногие", :type => 'Order'}
)

Family.seed(:id,
  {:id => 4, :name_ru => "Гагаровые", :type => 'Family'},
  {:id => 5, :name_ru => "Поганковые", :type => 'Family'},
  {:id => 6, :name_ru => "Пеликановые", :type => 'Family'}
)
