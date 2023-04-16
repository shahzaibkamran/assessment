class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,:rememberable,:recoverable,
         :validatable,:registerable,:jwt_authenticatable,
         jwt_revocation_strategy: self 

  def jwt_payload
    super
  end
end