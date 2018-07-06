require 'rails_helper'

RSpec.describe FavoriteJob, type: :model do
  describe 'db schema' do
    context 'index' do
      it do
        should have_db_index(:job_id)
        should have_db_index(:user_id)
      end
    end

    context 'foreign key' do
      it do
        should belong_to(:job).with_foreign_key('job_id')
        should belong_to(:user).with_foreign_key('user_id')
      end
    end
  end
end
