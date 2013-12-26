require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    before do
      @units = double('units selection')
      @note = mock_model(Note)
      @attachment = mock_model(Attachment)
      Unit.stub_chain(:order, :limit).and_return(@units)
      Note.stub(:new).and_return(@note)
      Attachment.stub(:new).and_return(@attachment)
    end

    it 'should provide units' do
      Unit.should_receive(:page).and_return(@units)
      get 'index'
      assigns(:units).should == @units
    end

    describe 'a user that is not logged in' do
      before do
        controller.stub(:current_user).and_return(nil)
      end

      it 'should be successful' do
        get 'index'
        response.should be_success
      end
    end

    describe 'a user that is logged in' do
      before do
        @folder = mock_model(Folder)
        @user = double(User)
        controller.stub(:current_user).and_return(@user)
      end

      it 'should be successful' do
        get 'index'
        response.should be_success
      end

      it 'should provide an empty attachment' do
        Attachment.should_receive(:new).and_return(@attachment)
        get 'index'
        assigns(:attachment).should == @attachment
      end

      it 'should provide an empty note' do
        Note.should_receive(:new).and_return(@note)
        get 'index'
        assigns(:note).should == @note
      end
    end
  end
end
