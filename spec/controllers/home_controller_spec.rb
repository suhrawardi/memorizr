require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    before do
      @units = double('units selection')
      Unit.stub(:page).and_return(@units)
      @note = mock_model(Note)
      Note.stub(:new).and_return(@note)
      @attachment = mock_model(Attachment)
      Attachment.stub(:new).and_return(@attachment)
    end

    describe 'a user that is not logged in' do
      before do
        controller.stub(:current_user).and_return(nil)
      end

      it 'should be successful' do
        get 'index'
        expect(response).to be_success
      end

      it 'should provide units' do
        Unit.should_receive(:page).and_return(@units)
        get 'index'
        expect(assigns(:units)).to eq(@units)
      end

      it 'does not provide an empty attachment' do
        Attachment.should_not_receive(:new)
        get 'index'
        expect(assigns(:attachment)).to be_nil
      end

      it 'does not provide an empty note' do
        Note.should_not_receive(:new)
        get 'index'
        expect(assigns(:note)).to be_nil
      end
    end

    describe 'a user that is logged in' do
      before do
        @folder = mock_model(Folder)
        @user = double(User)
        controller.stub(:current_user).and_return(@user)
      end

      it 'should provide units' do
        Unit.should_receive(:page).and_return(@units)
        get 'index'
        expect(assigns(:units)).to eq(@units)
      end

      it 'should be successful' do
        get 'index'
        expect(response).to be_success
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
