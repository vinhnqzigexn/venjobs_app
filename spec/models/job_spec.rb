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
    end

    context 'index' do
      it do
        should have_db_index(:title)
        should have_db_index(:city_id)
        should have_db_index(:company_id)
        should have_db_index(:industry_id)
        should have_db_index([:title, :update_date])
      end
    end

    context 'foreign key' do
      it do
        should belong_to(:company).with_foreign_key('company_id')
        should belong_to(:city).with_foreign_key('city_id')
        should belong_to(:industry).with_foreign_key('industry_id')
      end
    end
  end
end
