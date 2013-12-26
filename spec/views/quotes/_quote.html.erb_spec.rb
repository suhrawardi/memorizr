require 'spec_helper'

describe 'quotes/_quote.html.erb' do
  before do 
    @user = mock_model(User, :name => 'James')
    @quote = mock_model(Quote, :body => '<p>Quote body</p>',
                        :url => 'url', :title => 'title',
                        :page => @page, :user => @user,
                        :folder => mock_model(Folder),
                        :created_at => Time.now, :comments => [],
                        :editable? => false)
    view.stub(:current_user).and_return(mock_model(User))
    assign(:folder, mock_model(Folder))
  end 

  def do_render
    render :partial => 'quote', :object => @quote
  end

  it 'should render' do 
    do_render
    rendered.should have_selector('p', :text => 'Quote body')
  end 

  describe "the quote is by someone else's" do

    it 'should not have a highlight link' do
      do_render
      rendered.should_not have_selector('input[value="highlight"]')
    end

    it 'should not have a delete link' do
      do_render
      rendered.should_not have_selector('input[value="del"]')
    end

    it 'should not have a save link' do
      do_render
      rendered.should_not have_selector('input[value="save"]')
    end

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
