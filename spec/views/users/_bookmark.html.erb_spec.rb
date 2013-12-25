require 'spec_helper'

describe 'users/_bookmark.html.erb' do

  def do_render
    render :partial => 'bookmark'
  end

  describe 'for a logged in user' do
    before do
      @user = mock_model(User, submit_token: 't0K3n')
      view.stub(:current_user).and_return(@user)
    end
   
    it 'should have a link' do 
      do_render
      rendered.should have_selector('a')
    end 
  end

  describe 'for a user that is not logged in' do
    before do
      view.stub(:current_user).and_return(nil)
    end
   
    it 'should not have a link' do 
      do_render
      rendered.should_not have_selector('a')
    end 
  end
end
