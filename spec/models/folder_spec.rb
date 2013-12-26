require 'spec_helper'

describe Folder do
  describe 'validation' do
    before do
      @user = User.new
      @folder = Folder.new(:user => @user, :name => 'Folder name')
    end

    it 'should be valid' do
      @folder.should be_valid
    end

    it 'should not be valid without a user' do
      @folder.user = nil
      @folder.should_not be_valid
    end

    it 'should not be valid without a name' do
      @folder.name = ''
      @folder.should_not be_valid
    end

    it 'should also be valid when that user has a folder with that name' do
      Folder.create!(:user => @user, :name => 'common_name')
      @folder.name = 'common_name'
      @folder.should be_valid
    end
  end

  describe 'associations' do
    before do
      @folder = Folder.new
    end

    it 'should have a user' do
      @folder.should respond_to :user
    end

    it 'should have many units' do
      @folder.should respond_to :units
    end
  end

  describe 'mine?' do
    before do
      @user = User.create!(:name => 'user', :email => 'user@nu.nl',
                           :password => 's3cR3t')
      @folder = Folder.create!(:user => @user, :name => 'some-folder')
    end

    it 'should be mine' do
      @folder.mine?(@user).should be_true
    end

    it 'should not be some-one elses' do
      @folder.mine?(double(User)).should_not be_true
    end
  end
end
