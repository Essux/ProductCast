class Execution < ApplicationRecord
  belongs_to :forecast_set
  belongs_to :model
end
