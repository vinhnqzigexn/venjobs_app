# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { FactoryGirl.create(:company) }

  describe 'db schema' do
    it do
      should have_db_column(:name).of_type(:string)
      should have_db_column(:description).of_type(:text)
      should have_db_column(:address).of_type(:string)
      should have_db_column(:email).of_type(:string)
      should have_db_column(:phone).of_type(:string)
      should have_db_column(:fax).of_type(:string)
      should have_db_column(:number_of_employees).of_type(:string)
    end
  end

  it 'should be validates' do
    expect(company).to be_valid
  end

  describe 'validations' do
    it do
      should validate_presence_of(:name)
      should validate_length_of(:name).is_at_most(255)
      should validate_uniqueness_of(:name).case_insensitive

      should validate_presence_of(:description)
      should validate_presence_of(:address)
      should validate_length_of(:address).is_at_most(255)

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

      should validate_length_of(:phone).is_at_most(20)
      valid_phone_numbers = ['123-456-7890',
                             '(123) 456-7890',
                             '123 456 7890',
                             '123.456.7890',
                             '+91 (123) 456-7890']
      valid_phone_numbers.each do |phone_number|
        should allow_value(phone_number).for(:phone)
      end

      should validate_length_of(:fax).is_at_most(20)
      should validate_length_of(:number_of_employees).is_at_most(20)
    end
  end
end
