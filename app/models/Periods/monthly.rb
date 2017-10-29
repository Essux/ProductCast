require_relative './periodicity'
require 'date'

class Monthly < Periodicity
    def next_period(date)
        return date.next_month()
    end

    def previous_period(date)
        return date.prev_month()
    end
end