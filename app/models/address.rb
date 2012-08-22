class Address
  include Mongoid::Document
  field :street1,   type: String, null: false, default: ""
  field :street2,   type: String, null: false, default: ""
  field :city,   type: String, null: false, default: ""
  field :state,   type: String, null: false, default: ""
  field :zip,   type: Integer, null: false, default: 123456
  field :loc,   type: Array, null: false, default: []
  field :link,   type: String, null: false, default: ""
end
