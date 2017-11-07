class User < ApplicationRecord
  has_many :products
  has_many :forecast_sets, through: :products
  
  class << self
    # Crea u obtiene el usuario de un ingreso mediante Oauth
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.save!
      user
    end
  end
end
