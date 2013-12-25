require 'spec_helper'

describe UnitsController do
  before do
    controller.stub(:authenticate_user!)
  end

  describe "GET 'show'" do
    before do
      @unit = mock_model(Unit)
      @params = {:id => @unit.id}
      Unit.stub(:find).and_return(@unit)
      @comment = mock_model(Comment)
      Comment.stub(:new).and_return(@comment)
    end

    it 'should retrieve the requested unit' do
      Unit.should_receive(:find).once
      get :show, @params
    end

    it 'should assign a new comment' do
      get :show, @params
      assigns[:comment].should == @comment
    end

    it 'should assign the requested unit' do
      get :show, @params
      assigns[:unit].should == @unit
    end

    it 'should be success' do
      get :show, @params
      response.should be_success
    end

    it 'should authenticate the user' do
      controller.should_receive(:authenticate_user!)
      get :show, @params
    end
  end
end
