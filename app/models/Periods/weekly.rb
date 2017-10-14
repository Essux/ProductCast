require_relative './periodicity'
require 'date'

class Weekly < Periodicity
    def next_period(date)
        return date.next_day(7)
    end
    
    def previous_period(date)
        return date.prev_day(7)
    end
end