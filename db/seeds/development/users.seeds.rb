after :roles do
  User.seed(:id,
    { :id =>1, :email => 'user@example.com', :password => '111', :first_name => 'April', :last_name => 'May'},
    { :id =>2, :email => 'admin@example.com', :password => '111', :first_name => 'John', :last_name => 'Smith', :roles => [Role.find_by_name('admin'), Role.find_by_name('expert'), Role.find_by_name('owner')] },
    { :id =>3, :email => 'guest@example.com', :password => '111', :first_name => 'Bob', :last_name => 'Good', :big_year => false }
  )
end
