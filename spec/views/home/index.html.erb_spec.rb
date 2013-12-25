require 'spec_helper'

describe "home/index.html.erb" do
  before do 
    @user = mock_model(User, name: 'James')
    @quote = mock_model(Quote, body: '<p>Note</p>',
                        url: 'url', title: 'title', user: @user,
                        folder: mock_model(Folder),
                        created_at: Time.now, comments: [], is_editable?: false)
    @note = mock_model(Note, body: '', comments: [], created_at: Time.now,
                       body: '<p>Quote</p>', is_editable?: false, user: @user,
                       folder: mock_model(Folder))
    @image = double('image', thumb: double(url: '/path/to/thumb.png'),
                    url: '/path/to/img.png')
    @attachment = mock_model(Attachment, comments: [], created_at: Time.now,
                             is_editable?: false, user: @user,
                             attachment: @image, image?: true,
                             folder: mock_model(Folder))
    @array = [@quote, @note, @attachment] * 3
    @array.stub(:current_page).and_return(1)
    @array.stub(:total_pages).and_return(1)
    @array.stub(:limit_value).and_return(1)
    assign(:units, @array) 
    assign(:folder, mock_model(Folder))
    view.stub(:show_flash) 
    view.stub(:current_user).and_return(mock_model(User, name: 'someone'))
  end 

  def do_render
    render template: 'home/index', handlers: [:erb]
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
 
  it 'should render a selection of attachments' do 
    do_render
    view.should render_template(partial: 'attachments/_attachment', count: 3)
  end 
 
  it 'should render a selection of quotes' do 
    do_render
    view.should render_template(partial: 'quotes/_quote', count: 3)
  end 
end
