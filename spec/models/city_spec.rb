# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  let(:city) { FactoryGirl.create(:city) }

  describe 'db schema' do
    it do
      should have_db_column(:name).of_type(:string)
      should have_db_column(:city_type).of_type(:string)
      should have_db_column(:slug).of_type(:string)
      should have_db_column(:name_with_type).of_type(:string)
      should have_db_column(:path).of_type(:string)
      should have_db_column(:code).of_type(:integer)
      should have_db_column(:parent_code).of_type(:integer)
    end

    it { should have_many(:jobs).dependent(:destroy) }
  end

  it 'right values input' do
    expect(city).to be_valid
  end

  describe 'validations' do
    it do
      should validate_presence_of(:name)
      should validate_length_of(:name).is_at_most(255)
      should validate_uniqueness_of(:name).case_insensitive

      should validate_length_of(:city_type).is_at_most(255)
      should validate_length_of(:slug).is_at_most(255)
      should validate_length_of(:name_with_type).is_at_most(255)
      should validate_length_of(:path).is_at_most(255)
    end
  end
end
