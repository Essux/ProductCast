class Execution < ApplicationRecord
  belongs_to :forecast_set
  belongs_to :model
  has_many :forecasts
  has_many :applied_parameters
  has_many :tracking_signals
end
