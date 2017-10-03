require_relative './../Data/time_series'

puts "Model loaded"

class Model
    attr_reader :model_id, :name
    attr_accessor :parameters

    def initialize(model_id, name, parameters)
        @model_id = model_id
        @name = name
        @parameters = parameters
    end

    def run(historical_data, num_of_predictions)
        raise 'Not implemented!'
    end
end