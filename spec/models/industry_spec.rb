require 'rails_helper'

RSpec.describe Industry, type: :model do
  describe 'db schema' do
    context 'colums' do
      it { should have_db_column(:name).of_type(:string) }
    end
  end
end
