require 'spec_helper'

describe "units/show.html.erb" do
  before do 
    @user = mock_model(User, name: 'James')
    @comment = mock_model(Comment, unit: mock_model(Unit), created_at: Time.now,
                          user: mock_model(User))
    view.stub(:current_user).and_return(@user)
    view.stub(:show_flash) 
    assign(:folder, mock_model(Folder))
  end 

  def do_render
    render :template => 'units/show', :handlers => [:erb] 
  end

  describe 'for a quote' do
    before do
      @quote = mock_model(Quote, :body => '<p>Quote</p>',
                          :url => 'url', :title => 'title',
                          :user => @user, :created_at => Time.now,
                          :folder => mock_model(Folder),
                          :mine? => false, :editable? => false,
                          :comments => [@comment] * 4)
      assign(:unit, @quote)
      assign(:comment, mock_model(Comment, unit: @quote))
    end
   
    it 'should render' do 
      do_render
      rendered.should have_selector('body')
    end 
   
    it 'should render the quote' do 
      do_render
      view.should render_template(:partial => 'quotes/_quote')
    end 

    it 'should render the comment form' do
      do_render
      view.should render_template(:partial => 'comments/_comment_form')
    end
   
    it 'should render the comments' do 
      do_render
      view.should render_template(:partial => 'comments/_comment', :count => 4)
    end 
  end

  describe 'for a note' do
    before do
      @note = mock_model(Note, :body => '<p>Note</p>', :user => @user,
                         :created_at => Time.now, :folder => mock_model(Folder),
                         :mine? => false, :editable? => false,
                         :comments => [@comment] * 4)
      assign(:unit, @note)
      assign(:comment, mock_model(Comment, unit: @note))
    end
   
    it 'should render' do 
      do_render
      rendered.should have_selector('body')
    end 
   
    it 'should render the note' do 
      do_render
      view.should render_template(:partial => 'notes/_note')
    end 

    it 'should render the comment form' do
      do_render
      view.should render_template(:partial => 'comments/_comment_form')
    end
   
    it 'should render the comments' do 
      do_render
      view.should render_template(:partial => 'comments/_comment', :count => 4)
    end 
  end

  describe 'for a attachment' do
    before do
      @image = double('image', thumb: double(url: '/path/to/thumb.png'),
                      url: '/path/to/img.png')
      @attachment = mock_model(Attachment, attachment: @image, image?: true,
                               user: @user, created_at: Time.now,
                               folder: mock_model(Folder), mine?: false,
                               editable?: false, comments: [@comment] * 4)
      assign(:unit, @attachment)
      assign(:comment, mock_model(Comment, unit: @attachment))
    end
   
    it 'should render' do 
      do_render
      rendered.should have_selector('body')
    end 
   
    it 'should render the attachment' do 
      do_render
      view.should render_template(partial: 'attachments/_attachment')
    end 

    it 'should render the comment form' do
      do_render
      view.should render_template(partial: 'comments/_comment_form')
    end
   
    it 'should render the comments' do 
      do_render
      view.should render_template(partial: 'comments/_comment', count: 4)
    end 
  end
end
