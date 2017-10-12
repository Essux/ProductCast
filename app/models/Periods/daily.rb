require_relative './periodicity'
require 'date'

class Daily < Periodicity
    def next_period(date)
        return date.next_day()
    end
    
    def previous_period(date)
        return date.prev_day()
    end
end