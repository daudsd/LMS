# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name
  validates_presence_of :email

  after_create :assign_role

  def admin?
    has_role?(:admin)
  end
  
  def student?
    has_role?(:student)
  end

  private

  def assign_role
    add_role :student
  end
end
