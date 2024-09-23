class User < ApplicationRecord
    has_one :wallet, as: :entity, dependent: :destroy
    has_secure_password
  end
  
  class Team < ApplicationRecord
    has_one :wallet, as: :entity, dependent: :destroy
  end