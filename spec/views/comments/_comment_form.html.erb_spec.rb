require 'spec_helper'

describe 'comments/_comment_form.html.erb' do
  before do 
    @unit = mock_model(Unit)
    @comment = mock_model(Comment, unit: @unit)
  end 

  def do_render
    render :partial => 'comment_form', :object => @comment
  end

  describe 'for a logged in user' do
    before do
      view.stub(:current_user).and_return(mock_model(User))
    end
    
    it 'should render' do 
      do_render
      rendered.should have_selector('form')
    end 

    it 'should have the ckeditor' do
      do_render 
      rendered.should have_xpath("//textarea[@id='comment_body']")
    end
  end

  describe 'for a user that is not logged in' do
    before do
      view.stub(:current_user).and_return(nil)
    end
    
    it 'should render' do 
      do_render
      rendered.should_not have_selector('form')
    end 

    it 'should have the ckeditor' do
      do_render 
      rendered.should_not have_xpath("//textarea[@id='comment_body']")
    end
  end
end
