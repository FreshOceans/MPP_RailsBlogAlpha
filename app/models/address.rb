class Address < ApplicationRecord
  belongs_to :user

  validates :street, :presence => { :message => "Please enter a valid street name" }
  validates :city, :presence => { :message => "Please enter a valid city name" }
  validates :state, :presence => { :message => "Please enter a valid state name" }
  validates :zip, :presence => { :message => "Please enter a valid zipcode" }, :numericality => true, length: {is: 5}

end

# ======= validations2 =======

# • add after_validation callback to Address model
#     after_validation :geocode_address
#     def geocode_address
#       self.latlon = Geocoder.new(request.ip)
#     end
