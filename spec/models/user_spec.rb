require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user)  { build :user }
  let(:user_with_lowercase_password) { build(:user, password: Faker::Internet.password(min_length: 10, 
                                                                                       max_length: 16, 
                                                                                       mix_case: false)) }

  it 'is not valid without a name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'is not valid without a password' do
    user.password = nil
    expect(user).to_not be_valid
  end
  
  context 'password strength' do
    it 'is not valid without upper and lowercase characters in password' do
      expect(user_with_lowercase_password).to_not be_valid
    end
    
    it 'is not valid without at-least one digit in the password' do
      user.password = 'Helloworldtest'
      expect(user_with_lowercase_password).to_not be_valid
    end

    it 'is not valid with 3 or more repeating characters in the password' do
      user.password = 'HelllowWord123'
      expect(user_with_lowercase_password).to_not be_valid
    end
  end

  it 'is valid with correct password and name' do
    expect(user).to be_valid
  end
end
