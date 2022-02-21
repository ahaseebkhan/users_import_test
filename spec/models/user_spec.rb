require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user)  { build :user }
  let(:user_with_lowercase_password) { build(:user, password: Faker::Internet.password(min_length: 10, 
                                                                                       max_length: 16, 
                                                                                       mix_case: false)) }
  let!(:invalid_password_1)   { build(:user, password: 'Helloworl') } # 1 change required
  let!(:invalid_password_2)   { build(:user, password: 'Helloworld') } # 1 change required
  let!(:invalid_password_3)   { build(:user, password: 'helloworld111') } # 1 change required
  let!(:invalid_password_4)   { build(:user, password: 'helloworlDpoaaaa') } # 1 change required
  let!(:invalid_password_5)   { build(:user, password: 'helloooo') } # 2 changes required
  let!(:invalid_password_6)   { build(:user, password: 'ooooooo') } # 3 changes required
  let!(:invalid_password_7)   { build(:user, password: 'Longtextwithoutnumbers1111') } # 10 changes required
  let!(:invalid_password_8)   { build(:user, password: 'Short') } # 5 changes required
  let!(:invalid_password_9)   { build(:user, password: 'AAAfk1swods') } # 1 changes required
  let!(:invalid_password_10)   { build(:user, password: 'Abc123') } # 4 changes required
  let!(:invalid_password_11)   { build(:user, password: '000aaaBBBccccDDD') } # 5 changes required

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

    it 'is not valid without strong password' do
      invalid_password_1.save
      expect(invalid_password_1).to_not be_valid
      expect(invalid_password_1.errors[:change][0]).to eq("1 characters of #{invalid_password_1.name}'s password")
    end

    it 'is not valid without strong password' do
      invalid_password_2.save
      expect(invalid_password_2).to_not be_valid
      expect(invalid_password_2.errors[:change][0]).to eq("1 characters of #{invalid_password_2.name}'s password")
    end

    it 'is not valid without strong password' do
      invalid_password_3.save
      expect(invalid_password_3).to_not be_valid
      expect(invalid_password_3.errors[:change][0]).to eq("1 characters of #{invalid_password_3.name}'s password")
    end

    it 'is not valid without strong password' do
      invalid_password_4.save
      expect(invalid_password_4).to_not be_valid
      expect(invalid_password_4.errors[:change][0]).to eq("1 characters of #{invalid_password_4.name}'s password")
    end

    it 'is not valid without strong password' do
      invalid_password_5.save
      expect(invalid_password_5).to_not be_valid
      expect(invalid_password_5.errors[:change][0]).to eq("2 characters of #{invalid_password_5.name}'s password")
    end

    it 'is not valid without strong password' do
      invalid_password_6.save
      expect(invalid_password_6).to_not be_valid
      expect(invalid_password_6.errors[:change][0]).to eq("3 characters of #{invalid_password_6.name}'s password")
    end

    it 'is not valid without strong password' do
      invalid_password_7.save
      expect(invalid_password_7).to_not be_valid
      expect(invalid_password_7.errors[:change][0]).to eq("10 characters of #{invalid_password_7.name}'s password")
    end

    it 'is not valid without strong password' do
      invalid_password_8.save
      expect(invalid_password_8).to_not be_valid
      expect(invalid_password_8.errors[:change][0]).to eq("5 characters of #{invalid_password_8.name}'s password")
    end

    it 'is not valid without strong password' do
      invalid_password_9.save
      expect(invalid_password_9).to_not be_valid
      expect(invalid_password_9.errors[:change][0]).to eq("1 characters of #{invalid_password_9.name}'s password")
    end

    it 'is not valid without strong password' do
      invalid_password_10.save
      expect(invalid_password_10).to_not be_valid
      expect(invalid_password_10.errors[:change][0]).to eq("4 characters of #{invalid_password_10.name}'s password")
    end

    it 'is not valid without strong password' do
      invalid_password_11.save
      expect(invalid_password_11).to_not be_valid
      expect(invalid_password_11.errors[:change][0]).to eq("5 characters of #{invalid_password_11.name}'s password")
    end
  end

  it 'is valid with correct password and name' do
    expect(user).to be_valid
  end
end
