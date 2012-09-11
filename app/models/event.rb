class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title
  field :subtitle
  field :description
  field :date, type: Date, default: Date.today
  field :all_day, type: Boolean, default: false
  field :start_time, type: Time, default: Time.now
  field :end_time, type: Time, default: ->{ start_time + 1.hour }
  field :appears, type: DateTime, default: DateTime.now
  field :expires, type: DateTime, default: ->{ start_time + 1.day }
  field :signup_url
  field :artwork_url
  
  def cal_json
  	{ date: "#{date.month}/#{date.day}", title: title, id: _id }
  end
  
  def update_attributes(params)
    date = Date.civil(params['date(1i)'].to_i,params['date(2i)'].to_i,params['date(3i)'].to_i)
    super
  end
end
