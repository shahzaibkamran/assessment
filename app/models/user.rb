class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,:rememberable,:recoverable,:confirmable,
         :validatable,:registerable,:jwt_authenticatable,
         jwt_revocation_strategy: self

  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_default_admin, :if => :new_record?

  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "must be a valid email address" }
  validates :email, presence: true, uniqueness: true

  enum role: [:reader,:admin]

  scope :requests, -> { where(admin: true) }

  def set_default_role
    self.role ||= :user 
  end

  def set_default_admin
    self.admin ||= :user 
  end

  def jwt_payload
    super
  end

  #overriding the default after_confirmation callback
  def after_confirmation
    super
    SendinblueWorker.perform_async(self.email, self.name)
  end
end
