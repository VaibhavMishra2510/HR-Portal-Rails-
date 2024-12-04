class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    attribute :role, :string
    enum role: { admin: 'admin', manager: 'manager', employee: 'employee' }
      after_initialize :set_default_role, if: :new_record?
  private
  def self.from_google(email:, uid: )
    find_or_create_by!(email: email, uid: uid, provider: 'google_oauth2')
  end
  def set_default_role
    self.role ||= 'employee'
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]
end
