require "machinist/active_record"
require "sham"
require "faker"

Sham.define do
  login { Faker::Name.first_name.downcase }
  name { ['administrator', 'moderator', 'editor', 'uploader'].rand }
end

User.blueprint do
  login { Sham.login }
end

Role.blueprint do
  name { Sham.name }
end