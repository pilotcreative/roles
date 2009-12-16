ActiveRecord::Schema.define(:version => 3) do
  create_table :users do |t|
    t.string :login
  end
  
  create_table :roles do |t|
    t.string :name
  end
  
  create_table :privileges, :id => false do |t|
    t.integer :user_id
    t.integer :role_id
  end
end