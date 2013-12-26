require 'spec_helper'

describe Unit do
  describe 'validation' do
    before do
      @user = mock_model(User)
      @unit = Unit.new(:user => @user)
    end

    it 'should be valid' do
      @unit.should be_valid
    end

    it 'should not be valid without a user' do
      @unit.user = nil
      @unit.should_not be_valid
    end
  end

  describe 'associations' do
    before do
      @unit = Unit.new
    end

    it 'should have a user' do
      @unit.should respond_to :user
    end

    it 'should have a folder' do
      @unit.should respond_to :user
    end
  end

  describe 'mine?' do
    before do
      @user = mock_model(User)
      @unit = Unit.new(:user => @user)
    end

    it 'should return false for no given user' do
      @unit.mine?(nil).should be_false
    end

    it 'should return false for another given user' do
      another_user = mock_model(User, :email => 'jo@nu.nl')
      @unit.mine?(another_user).should be_false
    end

    it 'should return true when the unit belongs to the given user' do
      @unit.mine?(@user).should be_true 
    end
  end

  describe 'editable?' do
    before do
      @user = mock_model(User)
      @unit = Unit.new(user: @user)
    end

    it 'should return false for no given user' do
      @unit.editable?(nil).should be_false
    end

    it 'should return false for another given user' do
      another_user = mock_model(User, :email => 'jo@nu.nl')
      @unit.editable?(another_user).should be_false
    end

    it 'should return true when the unit belongs to the given user' do
      @unit.editable?(@user).should be_true 
    end
  end
end
