require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }

  describe 'db schema' do
    it do
      should have_db_column(:name).of_type(:string)
      should have_db_column(:prefix).of_type(:string)
      should have_db_column(:phone).of_type(:string)
      should have_db_column(:registration).of_type(:boolean)
      should have_db_column(:email).of_type(:string)
      should have_db_column(:encrypted_password).of_type(:string)
      should have_db_column(:reset_password_token).of_type(:string)
      should have_db_column(:reset_password_sent_at).of_type(:datetime)
      should have_db_column(:remember_created_at).of_type(:datetime)
      should have_db_column(:confirmation_token).of_type(:string)
      should have_db_column(:confirmed_at).of_type(:datetime)
      should have_db_column(:confirmation_sent_at).of_type(:datetime)
      should have_db_column(:unconfirmed_email).of_type(:string)
    end
    
    it { should have_many(:entries).dependent(:destroy) }
    it { should have_many(:favorite_jobs).dependent(:destroy) }
  end

  # it 'right values input' do
  #   expect(user).to be_valid
  # end

  describe 'validations' do
    it do
      should validate_presence_of(:name)
      should validate_length_of(:name).is_at_most(255)

      should validate_presence_of(:prefix)

      should validate_length_of(:phone).is_at_most(50)
      valid_phone_numbers = ['123-456-7890',
                             '(123) 456-7890',
                             '123 456 7890',
                             '123.456.7890',
                             '+91 (123) 456-7890']
      valid_phone_numbers.each do |phone_number|
        should allow_value(phone_number).for(:phone)
      end

      should validate_length_of(:email).is_at_most(255)
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      valid_addresses = %w[ user@example.com
                            USER@foo.COM
                            A_US-ER@foo.bar.org
                            first.last@foo.jp
                            alice+bob@baz.cn ]
      valid_addresses.each do |valid_address|
        should allow_value(valid_address).for(:email)
      end

      should validate_presence_of(:password)
      should validate_length_of(:password).is_at_least(8)

    end
  end
end
