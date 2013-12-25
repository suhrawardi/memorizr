require 'spec_helper'

describe AttachmentsController do
  before do
    controller.stub(:authenticate_user!)
  end

  describe "POST 'create'" do
    before do
      @params = {'attachment' => {'image_file_name' => 'test.png'}}
      @user = double(User)
      controller.stub(:current_user).and_return(@user)
      @attachment = double(Attachment)
      @folder = double(Folder)
      @attachment.stub(:folder).and_return(@folder)
      Attachment.stub(:create!).and_return(@attachment)
    end

    it 'should create a attachment' do
      params = @params['attachment'].merge('user' => @user)
      Attachment.should_receive(:create!).with(params)
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
      @exception = ActiveRecord::RecordInvalid.new(Attachment.new)
      Attachment.should_receive(:create!).and_raise(@exception)
      post :create, @params
      flash[:alert].should_not be_nil
    end

    it 'should redirect to the home page on error' do
      @exception = ActiveRecord::RecordInvalid.new(Attachment.new)
      Attachment.should_receive(:create!).and_raise(@exception)
      post :create, @params
      response.should redirect_to root_path
    end

    it 'should provide a flash message' do
      post :create, @params
      flash[:message].should_not be_nil
    end
  end
end
