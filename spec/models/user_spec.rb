require 'spec_helper'

describe User do
  describe 'validation' do
    before do
      @user = User.new(name: 'user', email: 'user@nu.nl', password: 's3cR3t')
    end

    it 'should be valid' do
      @user.should be_valid
    end

    describe 'name validation' do
      it 'should not be valid without a name' do
        @user.name = nil
        @user.should_not be_valid
      end

      it 'should not be valid with a name that is too short' do
        @user.name = 'a'
        @user.should_not be_valid
      end

      it 'should not be valid with a name that is not the correct format' do
        @user.name = "a user's world"
        @user.should_not be_valid
      end
    end
  end

  describe 'associations' do
    before do
      @user = User.new(:name => 'user', :email => 'user@nu.nl',
                       :password => 's3cR3t')
    end

    it 'should have notes' do
      @user.should respond_to :notes
    end

    it 'should have quotes' do
      @user.should respond_to :quotes
    end

    it 'should have folders' do
      @user.should respond_to :folders
    end

    it 'should have units' do
      @user.should respond_to :units
    end
  end

  describe 'on create' do
    before do
      @user = User.new(:name => 'user', :email => 'user@nu.nl',
                       :password => 's3cR3t')
    end

    it 'should generate a submit_token' do
      @user.save!
      @user.submit_token.should_not be_nil
    end
  end
end
