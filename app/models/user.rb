class User < ApplicationRecord
  has_many :products
  has_many :forecast_sets, through: :products
  
  class << self
    # Crea u obtiene el usuario de un ingreso mediante Oauth
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.first_name = auth_hash['info']['first_name']
      if auth_hash['provider'] == 'google'
        user.full_name = auth_hash['info']['name']
        user.image_url = auth_hash['info']['image']
      else
        user.full_name = user.first_name
        user.image_url = "logo.png"
      end
      user.save!
      user
    end
  end
end
