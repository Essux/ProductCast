class Product < ApplicationRecord
    has_many :records
    validates :name, presence: true, length: {in: 4..100}
end
