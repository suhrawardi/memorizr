require 'spec_helper'

describe QuotesController do
  before do
    controller.stub(:authenticate_user!)
  end

  describe "GET 'create'" do
    before do
      @params = {body: 'A quote', url: 'http://nu.nl/',
                 title: 'Yes!', token: 't0K3n'}
      User.stub(:find_by_submit_token).and_return(double(User))
      Quote.stub(:create_with_page)
    end

    it 'should find the submitting user' do
      User.should_receive(:find_by_submit_token).and_return(double(User))
      post :create, {format: :js}.merge!(@params)
    end

    it 'should create a quote' do
      Quote.should_receive(:create_with_page)
      post :create, {format: :js}.merge!(@params)
    end

    it 'should be a redirect' do
      post :create, {format: :js}.merge!(@params)
      response.should be_redirect
    end

    it 'should not authenticate the user' do
      controller.should_not_receive(:authenticate_user!)
      post :create, {format: :js}.merge!(@params)
    end

    it 'should provide a flash alert on error' do
      @exception = ActiveRecord::RecordInvalid.new(Quote.new)
      Quote.should_receive(:create_with_page).and_raise(@exception)
      post :create, {format: :js}.merge!(@params)
      flash[:alert].should_not be_nil
    end
  end

  describe "GET 'update'" do
    before do
      @params = {body: 'A quote', id: 1}
      @user = mock_model(User)
      @quote = mock_model(Quote, user: @user)
      @quote.stub(:update_attribute)
      Quote.stub(:find).and_return(@quote)
      @quote.stub(:mine?).and_return(true)
    end

    it 'should find the quote' do
      Quote.should_receive(:find).with('1').and_return(@quote)
      put :update, {format: :js}.merge!(@params)
    end

    it 'should not update for a quote by another user' do
      @quote.stub(:mine?).and_return(false)
      @quote.should_not_receive(:update_attribute)
      put :update, {format: :js}.merge!(@params)
    end

    it 'should update the quote' do
      @quote.should_receive(:update_attribute).with(:body, 'A quote')
      put :update, {format: :js}.merge!(@params)
    end

    it 'should be successful' do
      put :update, {format: :js}.merge!(@params)
      response.should be_success
    end

    it 'should provide a useful error when something goes wrong' do
      @quote.stub(:mine?).and_return(false)
      put :update, {format: :js}.merge!(@params)
      response.body.should == 'Unauthorized!'
    end
  end
end
