require 'spec_helper'

describe 'notes/_note.html.erb' do
  before do 
    @user = mock_model(User, :name => 'James')
    @note = mock_model(Note, :body => '<p>Note body</p>',
                        :created_at => Time.now, :comments => [],
                        :user => @user, :is_editable? => false,
                        :is_sortable? => false, :folder => mock_model(Folder))
    view.stub(:current_user).and_return(mock_model(User))
    assign(:folder, mock_model(Folder))
  end 

  def do_render
    render :partial => 'note', :object => @note
  end

  it 'should render' do 
    do_render
    rendered.should have_selector('p', text: 'Note body')
  end 

  describe "the note is by someone else's" do

    it 'should not have a edit link' do
      do_render
      rendered.should_not have_xpath('//a[contains(@href, "inEditMode")]')
    end

    it 'should not have a hidden view link' do
      do_render
      rendered.should_not have_xpath('//a[contains(@href, "inViewMode")]')
    end
  end
end
