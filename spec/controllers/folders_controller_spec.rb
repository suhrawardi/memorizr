require 'spec_helper'

describe FoldersController do
  before do
    controller.stub(:authenticate_user!)
  end

  describe "GET 'show'" do

    before do
      @user = double(User)
      controller.stub(:current_user).and_return(@user)
      @folder = mock_model(Folder, :name => 'FolderName')
      Folder.stub(:find).and_return(@folder)
      @note = mock_model(Note)
      Note.stub(:new).and_return(@note)
    end

    it 'should provide the selected folder' do
      Folder.should_receive(:find).and_return(@folder)
      get :show, id: 1
      assigns(:folder).should == @folder
    end

    it 'should be successful' do
      get :show, id: 1
      response.should be_success
    end

    it 'should authenticate the user' do
      controller.should_receive(:authenticate_user!)
      get :show, id: 1
    end

    it 'should trigger the Ckeditor JS' do
      get :show, id: 1
      assigns(:ckeditor).should be_true
    end

    it 'should provide an empty note' do
      Note.should_receive(:new).and_return(@note)
      get :show, id: 1
      assigns(:note).should == @note
    end
  end
end
