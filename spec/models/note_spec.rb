require 'spec_helper'

describe Note do
  describe 'validation' do
    before do
      @user = mock_model(User)
      @note = Note.new(body: '<p>body</p>', user: @user)
    end

    it 'should be valid' do
      @note.should be_valid
    end

    it 'should not be valid without a body' do
      @note.body = nil
      @note.should_not be_valid
    end

    it 'should not be valid without a user' do
      @note.user = nil
      @note.should_not be_valid
    end
  end

  describe 'associations' do
    before do
      @note = Note.new(:body => '<p>body</p>')
    end

    it 'should have a user' do
      @note.should respond_to :user
    end
  end
end
