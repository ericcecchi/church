namespace :db do
  desc "Create user records in the development database."
  
  task :groups => :environment do
		@mt_list = ['Ushers and Utility','Production','Administration','Guest Services','Communication','Worship Band','Prayer','Redemption Kids']
		@cg_list = ['Mundelein','Palatine North','Mount Prospect','Trinity']
		
		puts 'SETTING UP MISSIONAL TEAMS'
		@mt_list.each do |mt|
		  Group.create!(name: mt, type:"Missional Team")
		end
		puts "Created missional teams: " << @mt_list.to_sentence.titleize
		puts 'SETTING UP COMMUNITY GROUPS'
		@cg_list.each do |cg|
		  Group.create!(name: cg, type:"Community Group")
		end
		puts "Created community groups: " << @cg_list.to_sentence.titleize
	end
	
  task :fake => :environment do
		puts "Adding a bunch of fake users..."
    require 'faker'

    @genders = ["Male","Female"]
    @roles = ["admin","elder","leader","attender"]
    @probability = [0.02,0.05,0.23,0.7]

    def randomDate(params={})
      years_back = params[:year_range] || 5
      latest_year  = params [:year_latest] || 0
      year = (rand * (years_back)).ceil + (Time.now.year - latest_year - years_back)
      month = (rand * 12).ceil
      day = (rand * 28).ceil
      Date.civil(year, month, day)
    end
    
    def random
      randint = ((self.count-1)*rand).floor
      return self[randint]
    end

    100.times do
    	a = Address.new(
  		  :street1 => Faker::Address.street_address,
			  :street2 => Faker::Address.secondary_address,
			  :city => Faker::Address.city,
			  :state => Faker::Address.state_abbr,
			  :zip => Faker::Address.zip_code,
			  :loc => [],
			  :link => ''
			)
			
      rand_role = rand
      if rand_role <= @probability[0]
      	r = @roles[0]
      elsif rand_role <= @probability[1]
      	r = @roles[1]
      elsif rand_role <= @probability[2]
      	r = @roles[2]
      else
      	r = @roles[3]
      end
      
			first = Faker::Name.first_name
			last = Faker::Name.last_name
			uname = Faker::Internet.user_name
			
      u = User.new(
        :first_name => first,
        :last_name => last,
        :birthday => randomDate(:year_range => 70, :year_latest => 22),
        :created_at => randomDate(:year_range => 4, :year_latest => 0),
        :phone => ((rand(900) + 100).to_s + (rand(900) + 100).to_s + (rand(9000) + 1000).to_s).to_i,
        :twitter_username => uname,
        :facebook_url => uname,
        :accepts_terms_and_conditions => true,
        :gender => @genders.sample,
        :email => Faker::Internet.email,
        :role_id => r,
      )
      if r == 'attender'
      	u.member = [true,false].sample
      else
        u.member = true
      end
      u.groups << Group.where(type: 'Community Group').random
      u.groups << Group.where(type: 'Missional Team').random
      u.address = a
      u.admin_create
      u.save!

    end
    puts "...done."
  end
end