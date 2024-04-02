# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

unless User.find_by(email: 'kuldeep@gmail.com').present?
  User.create(email: 'kuldeep@gmail.com', password: 'password', name: 'Kuldeep Chotaliya')
  p 'User created-----------------------------'
end

unless Admin.find_by(email: 'admin@gmail.com').present?
  Admin.create(email: 'admin@gmail.com', password: 'admin123', name: 'Test Admin')
  p 'Admin Created------------------------------'
end
