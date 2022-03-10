class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def current_user
    RequestStore[:current_user]
  end

  def self.current_user
    RequestStore[:current_user]
  end
end
