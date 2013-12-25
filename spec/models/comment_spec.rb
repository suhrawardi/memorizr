require 'spec_helper'

describe Comment do
  describe 'validation' do
    before do
      @user = mock_model(User)
      @unit = mock_model(Unit)
      @comment = Comment.new(body: '<p>body</p>', user: @user, unit: @unit)
    end

    it 'should be valid' do
      @comment.should be_valid
    end

    it 'should not be valid without a body' do
      @comment.body = nil
      @comment.should_not be_valid
    end

    it 'should not be valid without a user' do
      @comment.user = nil
      @comment.should_not be_valid
    end

    it 'should not be valid without a unit' do
      @comment.unit = nil
      @comment.should_not be_valid
    end
  end

  describe 'associations' do
    before do
      @comment = Comment.new(body: '<p>body</p>')
    end

    it 'should have a unit' do
      @comment.should respond_to :unit
    end

    it 'should have a user' do
      @comment.should respond_to :user
    end
  end

  describe 'touch_unit' do
    before do
      @user = mock_model(User)
      @unit = mock_model(Unit)
    end

    it 'should call :touch_unit' do
      expect(@unit).to receive(:touch).once
      Comment.create!(user: @user, unit: @unit, body: 'text')
    end
  end
end
