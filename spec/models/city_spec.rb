require 'rails_helper'

RSpec.describe City, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'db schema' do
    context 'colums' do
      it do
        should have_db_column(:name).of_type(:string)
        should have_db_column(:type).of_type(:string)
        should have_db_column(:slug).of_type(:string)
        should have_db_column(:name_with_type).of_type(:string)
        should have_db_column(:path).of_type(:string)
        should have_db_column(:code).of_type(:integer)
        should have_db_column(:parent_code).of_type(:integer)
      end
    end
  end
end
