require 'spec_helper'

describe NotesController do
  before do
    controller.stub(:authenticate_user!)
  end

  describe "POST 'create'" do
    before do
      @params = {'note' => {'body' => 'A note'}}
      @user = double(User)
      controller.stub(:current_user).and_return(@user)
      @note = double(Note)
      @folder = double(Folder)
      @note.stub(:folder).and_return(@folder)
      Note.stub(:create!).and_return(@note)
    end

    it 'should create a note' do
      Note.should_receive(:create!).with(@params['note'].merge('user' => @user))
      post :create, @params
    end

    it 'should redirect to the folder show page' do
      post :create, @params
      response.should redirect_to root_path
    end

    it 'should authenticate the user' do
      controller.should_receive(:authenticate_user!)
      post :create, @params
    end

    it 'should provide a flash alert on error' do
      @exception = ActiveRecord::RecordInvalid.new(Note.new)
      Note.should_receive(:create!).and_raise(@exception)
      post :create, @params
      flash[:alert].should_not be_nil
    end

    it 'should redirect to the home page on error' do
      @exception = ActiveRecord::RecordInvalid.new(Note.new)
      Note.should_receive(:create!).and_raise(@exception)
      post :create, @params
      response.should redirect_to root_path
    end

    it 'should provide a flash message' do
      post :create, @params
      flash[:message].should_not be_nil
    end
  end
end
