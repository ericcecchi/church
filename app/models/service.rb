class Service < Event
  include Mongoid::Document
  has_one :sermon
end
