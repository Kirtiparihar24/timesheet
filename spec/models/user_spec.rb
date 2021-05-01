require 'rails_helper'

RSpec.describe User, type: :model do

  subject do
    described_class.new(name: 'Kirti Parihar', email: 'pariharkirti24@gmail.com', password: '123456', password_confirmation: '123456', role: 'teacher')
  end

  describe 'Validations' do

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    describe 'email uniqueness' do
      before { create :user, email: 'foo@bar.com' }
      let(:user) { build :user, email: 'foo@bar.com' }
      it do
        user.valid?
        expect(user.errors[:email]).to be == ['has already been taken']
      end
    end

    it 'is valid with valid email' do
      subject { build :user, name: 'Test Name', email: 'admin@example.com' }
      expect(subject).to be_valid
    end

    it 'is not valid without a valid email' do
      user = build :user, email: 'invalid email'
      expect(user).not_to be_valid
    end

    it 'is valid with minimum 6 digit password' do
      user = build :user, password: '1234467'
      expect(user).to be_valid
    end

    it 'is not valid without minimum 6 digit password' do
      user = build :user, password: '1234'
      expect(user).not_to be_valid
    end

  end

  describe 'Associations' do

    it { should have_many(:time_entries) }

  end

end
