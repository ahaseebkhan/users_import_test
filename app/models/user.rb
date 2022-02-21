class User < ApplicationRecord
  require 'csv'

  encrypts :password, deterministic: true # Application level encryption
  validates :password, presence: true, length: { minimum: 10, maximum: 16 }
  validate :password_strength
  validates_presence_of :name
  
  def self.import(file)
    users = []
    CSV.foreach(file.path, headers: true) { |row| users << User.create(row.to_hash) }
    users
  end
  
  private

  def password_strength
    characters_to_change = 0
    errors.add(:change, "10 character of #{name}'s password") && return unless password.present?
    characters_to_change += (10 - password.length) if errors.added?(:password, :too_short, count: 10)
    characters_to_change += (password.length - 16) if errors.added?(:password, :too_long, count: 16)
    characters_to_change += 1 unless password.match?(/(?=.*\d)/)
    characters_to_change += 1 unless password.match?(/(?=.*[a-z])/)
    characters_to_change += 1 unless password.match?(/(?=.*[A-Z])/)
    if password.match?(/((.)\2+{2})/)
      characters_to_change += password.scan(/((.)\2+{2})/).map { |x| (x[0].length/3) }.inject(:+)
    end

    errors.add(:change, "#{characters_to_change} character of #{name}'s password") if characters_to_change != 0
  end
end
