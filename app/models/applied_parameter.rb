class AppliedParameter < ApplicationRecord
  belongs_to :parameter
  belongs_to :execution
end
