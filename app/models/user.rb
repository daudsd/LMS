class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name
  validates_presence_of :email

  def admin?
    has_role?(:admin)
  end
  
  def student?
    has_role?(:student)
  end
end
