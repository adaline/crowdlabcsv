require 'rails_helper'

describe "User" do
  it "must have an email" do
    expect { FactoryGirl.create(:user, email: nil) }.to raise_error
  end

  context 'gender field' do
    it "must handle 'male' correctly" do
      user = FactoryGirl.build(:user, gender: 'male')
      expect(user).to be_valid
      # Expecations doubled up to save time
      user.save
      expect(user.gender).to eq('m')
    end

    it "must handle 'female'correctly" do
      user = FactoryGirl.build(:user, gender: 'female')
      expect(user).to be_valid
      # Expecations doubled up to save time
      user.save
      expect(user.gender).to eq('f')
    end

    it "must handle 'M' correctly" do
      user = FactoryGirl.build(:user, gender: 'M')
      expect(user).to be_valid
      # Expecations doubled up to save time
      user.save
      expect(user.gender).to eq('m')
    end

    it "must handle 'F' correctly" do
      user = FactoryGirl.build(:user, gender: 'F')
      expect(user).to be_valid
      # Expecations doubled up to save time
      user.save
      expect(user.gender).to eq('f')
    end
  end

end
