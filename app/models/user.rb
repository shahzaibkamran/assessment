class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,:rememberable,:recoverable,:confirmable,
         :validatable,:registerable,:jwt_authenticatable,
         jwt_revocation_strategy: self 
  enum role: [:reader,:admin]
  after_initialize :set_default_role, :if => :new_record?
  
  scope :requests, -> { where(admin: true) }

  def set_default_role
    self.role ||= :user 
  end

  def jwt_payload
    super
  end
end