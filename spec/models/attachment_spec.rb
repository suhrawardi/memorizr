require 'spec_helper'

describe Attachment do

  describe 'validation' do
    before do
      @user = mock_model(User)
      @unit = Attachment.new(user: @user)
    end

    it 'should be valid' do
      @unit.should be_valid
    end

    it 'should not be valid without a user' do
      @unit.user = nil
      @unit.should_not be_valid
    end
  end
end
