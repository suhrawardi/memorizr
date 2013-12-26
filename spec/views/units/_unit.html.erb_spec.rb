require 'spec_helper'

describe 'units/_unit.html.erb' do
  before do 
    @user = mock_model(User, :name => 'James')
    view.stub(:current_user).and_return(mock_model(User))
    assign(:folder, mock_model(Folder))
  end 

  def do_render(unit)
    render :partial => 'unit', :object => unit
  end

  describe 'for a note' do
    before do
      @note = mock_model(Note, :body => 'a Note', :user => @user,
                         :folder => mock_model(Folder), :editable? => true,
                         :comments => [], :created_at => Time.now)
    end

    it 'should render' do 
      do_render(@note)
      rendered.should =~ /a Note/
    end 

    it 'should render the note partial' do
      do_render(@note)
      view.should render_template(:partial => 'notes/_note')
    end
  end

  describe 'for a quote' do
    before do
      @quote = mock_model(Quote, :body => 'a Quote', :user => @user,
                         :comments => [], :folder => mock_model(Folder),
                         :editable? => true, :created_at => Time.now,
                         :url => 'url', :title => 'title')
    end

    it 'should render' do 
      do_render(@quote)
      rendered.should =~ /a Quote/
    end 

    it 'should render the quote partial' do
      do_render(@quote)
      view.should render_template(:partial => 'quotes/_quote')
    end
  end

  describe 'for a attachment' do
    before do
      @image = double('image', thumb: double(url: '/path/to/thumb.png'),
                      url: '/path/to/img.png')
      @attachment = mock_model(Attachment, attachment: @image, user: @user,
                               folder: mock_model(Folder), image?: true,
                               editable?: true,
                               comments: [], created_at: Time.now)
    end

    it 'should render' do 
      do_render(@attachment)
      rendered.should have_selector('img')
    end 

    it 'should render the attachments partial' do
      do_render(@attachment)
      view.should render_template(partial: 'attachments/_attachment')
    end
  end
end
