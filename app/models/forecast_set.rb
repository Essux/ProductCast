class ForecastSet < ApplicationRecord
  belongs_to :product
  has_many :executions
  has_many :models, through: :executions
end
