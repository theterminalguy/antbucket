require 'rails_helper'

RSpec.describe Paginator do
  before(:each) do
    @paginate = Paginator.new(page: 1, limit: 3)
  end

  context 'when given an object and fields to return' do
    before(:each) do
      3.times do
        create(:bucket_list, user: @user)
      end
    end
    it 'should paginate the result appropriately' do
      record = BucketList.all
      res = @paginate.paginate(record, [:id, :name])
      # expect(res[:total_records]).to eq 3
      # expect(res[:page]).to eq '1 of 1'
    end
  end
end
