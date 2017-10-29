class Model < ApplicationRecord
    has_many :parameters
    has_many :executions
    has_many :forecast_sets, through: :executions
end
