require 'spec_helper'

describe 'comments/_comment.html.erb' do
  before do 
    @user = mock_model(User, name: 'James')
    @comment = mock_model(Comment, body: '<p>Comment body</p>', user: @user,
                          created_at: Time.now)
    view.stub(:current_user).and_return(mock_model(User))
  end 

  def do_render
    render :partial => 'comment', :object => @comment
  end

  it 'should render' do 
    do_render
    rendered.should have_selector('p', text: 'Comment body')
  end 
end
