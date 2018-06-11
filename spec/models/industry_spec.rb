# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Industry, type: :model do
  let!(:industry) { FactoryGirl.create(:industry) }

  describe 'db schema' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_many(:jobs).dependent(:destroy) }
  end

  it 'right values input' do
    expect(industry).to be_valid
  end

  describe 'validations' do
    it do
      should validate_presence_of(:name)
      should validate_length_of(:name).is_at_most(255)
      should validate_uniqueness_of(:name).case_insensitive
    end
  end
end
