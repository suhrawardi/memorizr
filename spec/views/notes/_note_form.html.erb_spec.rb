require 'spec_helper'

describe 'notes/_note_form.html.erb' do
  before do 
    @tag = double('tag', :name => 'tag name')
    @folder = mock_model(Folder)
    @note = mock_model(Note, :body => '', :tags => [@tag], :folder => @folder)
    view.stub(:current_user).and_return(mock_model(User))
  end 

  def do_render
    render :partial => 'note_form', :object => @note
  end

  it 'should render' do 
    do_render
    rendered.should have_selector('form')
  end 
end
