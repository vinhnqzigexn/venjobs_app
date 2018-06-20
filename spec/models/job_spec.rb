# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'db schema' do
    context 'colums' do
      it do
        should have_db_column(:title).of_type(:string)
        should have_db_column(:position).of_type(:string)
        should have_db_column(:salary).of_type(:decimal)
        should have_db_column(:expiry_date).of_type(:datetime)
        should have_db_column(:description).of_type(:text)
        should have_db_column(:update_date).of_type(:datetime)
        should have_db_column(:published).of_type(:boolean)
        should have_db_column(:welfare).of_type(:text)
        should have_db_column(:condition).of_type(:text)
      end

      it { should have_many(:entries).dependent(:destroy) }
      it { should have_many(:favorite_jobs).dependent(:destroy) }
      it { should have_many(:cities_jobs).dependent(:destroy) }
      it { should have_many(:cities).through(:cities_jobs) }
      it { should have_many(:industries_jobs).dependent(:destroy) }
      it { should have_many(:industries).through(:industries_jobs) }
    end

    context 'index' do
      it do
        should have_db_index(:title)
        should have_db_index(:company_id)
      end
    end

    context 'foreign key' do
      it do
        should belong_to(:company).with_foreign_key('company_id')
      end
    end
  end

  let(:company) { FactoryGirl.create(:company) }
  let(:city) { FactoryGirl.create(:city) }
  let(:industry) { FactoryGirl.create(:industry) }
  let(:job) do
    FactoryGirl.create(
      :job,
      company_id: company.id
    )
  end

  it 'right values input' do
    expect(job).to be_valid
  end

  describe 'validate' do
    it do
      should validate_presence_of(:title)
      should validate_length_of(:title).is_at_most(255)
      should validate_uniqueness_of(:title).case_insensitive

      should validate_presence_of(:position)
      should validate_length_of(:position).is_at_most(255)

      should validate_presence_of(:salary)
      should allow_value('123456.67').for(:salary)
      should validate_numericality_of(:salary)
        .is_greater_than(0.00)
      should validate_numericality_of(:salary)
        .is_less_than(999_999_999_999.99)

      should validate_presence_of(:expiry_date)

      should validate_presence_of(:description)
      should validate_length_of(:description).is_at_most(1000)

      should validate_presence_of(:update_date)

      should validate_presence_of(:published)
      # should allow_value(true, false).for(:published)
      # should validate_inclusion_of(:published).in_array([true, false])

      should validate_presence_of(:welfare)
      should validate_length_of(:welfare).is_at_most(1000)

      should validate_presence_of(:condition)
      should validate_length_of(:condition).is_at_most(1000)

      should validate_presence_of(:link)
    end
  end
end
