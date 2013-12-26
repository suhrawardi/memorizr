require 'spec_helper'

describe "folders/show.html.erb" do
  before do 
    @user = mock_model(User, name: 'James')
    @folder = mock_model(Folder, name: 'FolderName',
                         description: 'FolderDescription')
    @note = mock_model(Note, comments: [], created_at: Time.now,
                       folder: @folder, body: '<p>Quote</p>', user: @user)
    @quote = mock_model(Quote, body: '<p>Note</p>',
                        url: 'url', title: 'title', user: @user,
                        folder: @folder, created_at: Time.now, comments: [])
    @image = double('image', thumb: double(url: '/path/to/thumb.png'),
                    url: '/path/to/img.png')
    @attachment = mock_model(Attachment, body: '', comments: [],
                             folder: @folder, attachment: @image,
                             created_at: Time.now, user: @user, image?: true)
    @folder.stub(:units).and_return([@quote, @note, @attachment] * 3)
    @note.stub(:editable?).and_return(true)
    @quote.stub(:editable?).and_return(true)
    @attachment.stub(:editable?).and_return(true)
    @folder.stub(:mine?).and_return(true)
    assign(:attachment, @attachment)
    assign(:note, @note)
    assign(:folder, @folder)
    view.stub(:show_flash) 
    view.stub(:current_user).and_return(mock_model(User, name: 'someone'))
  end 

  def do_render
    render template: 'folders/show', handlers: [:erb]
  end
 
  it 'should render' do 
    do_render
    rendered.should have_selector('body')
  end 
 
  it 'should render a selection of units' do 
    do_render
    view.should render_template(partial: 'units/_unit', count: 9)
  end 
 
  it 'should render a selection of notes' do 
    do_render
    view.should render_template(partial: 'notes/_note', count: 3)
  end 
 
  it 'should render a selection of quotes' do 
    do_render
    view.should render_template(partial: 'quotes/_quote', count: 3)
  end 
 
  it 'should render a selection of attachments' do 
    do_render
    view.should render_template(partial: 'attachments/_attachment', count: 3)
  end 

  it 'should have a attachment form' do
    do_render
    view.should render_template(partial: 'attachments/_attachment_form')
  end

  it 'should have a note form' do
    do_render
    view.should render_template(partial: 'notes/_note_form')
  end

  describe 'for a folder that belongs to the current user' do
    before do
      @folder.should_receive(:mine?).and_return(false)
    end
  end
end
