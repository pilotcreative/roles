ActiveRecord::Schema.define(:version => 3) do
  create_table :roles do |t|
    t.string :name
  end

  Role.create(:name => 'administrator')
  Role.create(:name => 'uploader')
  Role.create(:name => 'moderator')
  Role.create(:name => 'editor')

  create_table :privileges, :id => false do |t|
    t.integer :user_id
    t.integer :role_id
  end

  create_table :users do |t|
    t.string :login
  end
end