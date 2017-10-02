class Record < ApplicationRecord
  belongs_to :product
  validates :product, presence: true
  validates :date, uniqueness: { scope: :product }
end
