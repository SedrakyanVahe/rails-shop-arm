class ApplicationRecord < ActiveRecord::Base
  
  self.abstract_class = true
  attr_accessor :logged_in_user

  @@logged_in_user = nil?

  def self.set_logged_in_user(user)
    @@logged_in_user = user
  end  
end
