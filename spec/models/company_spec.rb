require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'db schema' do
    context 'colums' do
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
  end
end
