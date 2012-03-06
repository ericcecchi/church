# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
puts 'SETTING UP ROLES'
roles_list = [:admin,:elder,:elder_candidate,:mtl,:cgl,:member,:attender]
roles_list.each do |role|
  Role.create!(name: role)
end
puts "Created roles: " << roles_list.to_sentence.titleize
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create!(display_name: 'root', first_name: 'Admin', last_name: 'Istrator', email: 'modchvrch@gmail.com', password: 'password', password_confirmation: 'password', role_ids: [:admin])
puts 'Default username: ' << user.username, "Password: " << user.password

