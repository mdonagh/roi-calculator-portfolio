module RoisHelper
    Priorities = ['Priority',
                  'Reduce Return Visits', 
                  'Happy Customers', 
                  'Reducing Incorrect Part', 
                  'Optimize Fleets', 
                  'Improve Time to Repair', 
                  'Other']

=begin
  consolidate Optimize Fleets
  service-calls Improve Time to Repair
  fix-rates Reduce Return Visits
  incorrect-parts Reducing Incorrect Part
  happier-customers Happy Customers
=end

    def get_benefits_order priority
      benefits_order = ['consolidate', 'fix-rates', 'incorrect-parts', 'service-calls', 'happier-customers']
      case priority
        when "Optimize Fleets"
          return benefits_order.insert(0, benefits_order.delete('consolidate'))
        when "Improve Time to Repair"
          return benefits_order.insert(0, benefits_order.delete('service-calls'))
        when "Reducing Incorrect Part"
          return benefits_order.insert(0, benefits_order.delete('incorrect-parts'))
        when "Happy Customers"
          return benefits_order.insert(0, benefits_order.delete('happier-customers'))
        when "Return Visits"
          return benefits_order.insert(0, benefits_order.delete('fix-rates'))
        else
          return benefits_order
        end
    end

end
