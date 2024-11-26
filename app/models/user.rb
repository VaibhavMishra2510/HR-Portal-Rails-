class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    attribute :role, :string

    enum role: { admin: 'admin', manager: 'manager', employee: 'employee' }
      after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= 'employee'
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable
end
