require 'haversine'
require_relative 'customer'

class Inviter
  attr_reader :customers, :invitees
  OFFICE_LOCATION = [53.3393, -6.2576841]
  MAX_DISTANCE = 100

  def initialize
    @customers = Customer.parse_customer_list('./assets/gistfile1.json')
    @invitees = {}
  end

  def gather_invitees
    @customers.each do |customer|
      dist = Haversine.distance(customer.latitude, customer.longitude, *(OFFICE_LOCATION)).to_km

      @invitees[customer.user_id] = customer.name if dist < MAX_DISTANCE
    end
  end

  def sort_invitees
    @invitees.sort.to_h if @invitees.length > 1
  end
end
