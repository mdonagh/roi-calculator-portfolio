class Roi < ApplicationRecord
  require 'securerandom'
  before_create :calculate_roi
  before_create :create_uuid

  def calculate_roi
    self.profit_from_additional_truck_rolls = field_technicians * 7095
    self.eliminated_costs_from_return_visits = field_technicians * 15480
    self.total_annual_savings = profit_from_additional_truck_rolls + eliminated_costs_from_return_visits
    self.savings_per_service_tech = total_annual_savings / field_technicians
    
    if product_types * 24 / field_technicians + 8 <= 40
      self.monthly_pricing_per_service_tech = 40.00
    else
      self.monthly_pricing_per_service_tech = product_types * 24 / field_technicians + 8
    end

    self.total_roi = 100 * savings_per_service_tech / 12 / monthly_pricing_per_service_tech
    self.payback_achieved = ((monthly_pricing_per_service_tech * 12 / savings_per_service_tech) * 360).round
  end

  def create_uuid
    self.uuid = SecureRandom.uuid
  end

end
