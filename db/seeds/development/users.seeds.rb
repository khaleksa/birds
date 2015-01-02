after :roles do
  User.seed(:id,
    { :id =>1, :email => 'user@example.com', :password => '111' },
    { :id =>2, :email => 'admin@example.com', :password => '111', :roles => [Role.find_by_name('admin'), Role.find_by_name('expert')] }
  )
end
