include PasswordValidations
require 'csv'

class User < ApplicationRecord

  encrypts :password, deterministic: true # Application level encryption
  validate :password_strength_validation
  validates_presence_of :name
  
  def self.import(file)
    users = []
    CSV.foreach(file.path, headers: true) { |row| users << User.create(row.to_hash) }
    users
  end
end
