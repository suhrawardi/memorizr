require 'spec_helper'

describe CommentsController do
  before do
    controller.stub(:authenticate_user!)
  end

  describe "POST 'create'" do
    before do
      @unit = mock_model(Unit)
      @params = {'comment' => {'body' => 'Body', 'unit_id' => @unit.id.to_s}}
      @user = mock_model(User)
      @comment = mock_model(Comment)
      @comment.stub(:unit).and_return(@unit)
      controller.stub(:current_user).and_return(@user)
      Comment.stub(:create!).and_return(@comment)
    end

    it 'should create a comment' do
      @params['comment'].merge!('user' => @user)
      Comment.should_receive(:create!).with(@params['comment']).
        and_return(@comment)
      post :create, @params
    end

    it 'should redirect to the unit show page' do
      post :create, @params
      response.should redirect_to unit_path(@unit)
    end

    it 'should authenticate the user' do
      controller.should_receive(:authenticate_user!)
      post :create, @params
    end

    it 'should provide a flash alert on error' do
      @exception = ActiveRecord::RecordInvalid.new(Comment.new)
      Comment.should_receive(:create!).and_raise(@exception)
      post :create, @params
      flash[:alert].should_not be_nil
    end

    it 'should redirect to the home page on error' do
      @exception = ActiveRecord::RecordInvalid.new(Comment.new)
      Comment.should_receive(:create!).and_raise(@exception)
      post :create, @params
      response.should redirect_to home_index_path
    end

    it 'should provide a flash message' do
      post :create, @params
      flash[:message].should_not be_nil
    end
  end

end
