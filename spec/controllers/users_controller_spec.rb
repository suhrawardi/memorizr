require 'spec_helper'

describe UsersController do

  describe "GET 'units'" do
    before do
      @user = mock_model(User)
      User.stub(:find).and_return(@user)
      @units = double('units selection')
      Unit.stub_chain(:where, :page).and_return(@units)
      @note = mock_model(Note)
      Note.stub(:new).and_return(@note)
      @attachment = mock_model(Attachment)
      Attachment.stub(:new).and_return(@attachment)
    end

    describe 'a user that is not logged in' do

      it 'should not be successful' do
        get :units, id: 1
        expect(response).not_to be_success
      end
    end

    describe 'a user that is logged in' do
      before do
        controller.stub(:authenticate_user!)
        controller.stub(:current_user).and_return(@user)
      end

      it 'should be successful' do
        get :units, id: 1
        response.should be_success
      end

      it 'should provide units' do
        @relation = double(:relation)
        Unit.should_receive(:where).and_return(@relation)
        @relation.should_receive(:page).and_return(@units)
        get :units, id: 1
        assigns(:units).should == @units
      end

      it 'should provide an empty attachment' do
        Attachment.should_receive(:new).and_return(@attachment)
        get :units, id: 1
        assigns(:attachment).should == @attachment
      end

      it 'should provide an empty note' do
        Note.should_receive(:new).and_return(@note)
        get :units, id: 1
        assigns(:note).should == @note
      end
    end
  end
end
