require 'rails_helper'

RSpec.describe IndustriesJob, type: :model do
  describe 'db schema' do
    context 'index' do
      it do
        should have_db_index(:job_id)
        should have_db_index(:industry_id)
      end
    end

    context 'foreign key' do
      it do
        should belong_to(:job).with_foreign_key('job_id')
        should belong_to(:industry).with_foreign_key('industry_id')
      end
    end
  end

  describe 'validations' do
    it do
      should validate_presence_of(:job_id)
      should validate_presence_of(:industry_id)
    end
  end
end
