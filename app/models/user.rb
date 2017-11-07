class User < ApplicationRecord
  has_many :products
  
  class << self
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.save!
      user
    end
  end
end
