
puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
puts 'SETTING UP ROLES'
roles_list = [:admin,:elder,:leader,:attender]
roles_list.each do |role|
  Role.create!(name: role)
end
puts "Created roles: " << roles_list.to_sentence.titleize
puts 'SETTING UP MISSIONAL TEAMS'
mt_list = ['Ushers and Utility','Production','Administration','Guest Services','Communication','Worship Band','Prayer','Redemption Kids']
mt_list.each do |mt|
  Group.create!(name: mt, type:"Missional Team")
end
puts "Created missional teams: " << mt_list.to_sentence.titleize
puts 'SETTING UP COMMUNITY GROUPS'
cg_list = ['Mundelein','Palatine North','Mount Prospect','Trinity']
cg_list.each do |cg|
  Group.create!(name: cg, type:"Community Group")
end
puts "Created community groups: " << cg_list.to_sentence.titleize
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create!(display_name: 'root', first_name: 'Admin', last_name: 'Istrator', email: 'modchvrch@gmail.com', password: 'password', password_confirmation: 'password', role_id: :admin)
puts 'Default username: ' << user.username, "Password: " << user.password

