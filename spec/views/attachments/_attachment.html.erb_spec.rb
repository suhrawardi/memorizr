require 'spec_helper'

describe 'attachments/_attachment.html.erb' do
  before do 
    @user = mock_model(User, name: 'James')
  end 

  def do_render
    render partial: 'attachment', object: @attachment
  end

  describe 'with an image attachment' do
    before do 
      @image = double('image', thumb: double(url: '/path/to/thumb.png'),
                      url: '/path/to/img.png')
      @attachment = mock_model(Attachment, attachment: @image, image?: true,
                               created_at: Time.now, comments: [],
                               user: @user, folder: mock_model(Folder))
      do_render
    end 

    it 'shows the thumbnail' do 
      expect(rendered).to have_selector('img[src="/path/to/thumb.png"]')
    end 

    it 'links to the file' do 
      expect(rendered).to have_selector('a[href="/path/to/img.png"]')
    end 

    it 'shows a discuss link' do
      expect(rendered).to have_selector('a', text: 'discuss')
    end
  end

  describe 'with a file attachment' do
    before do 
      @image = double('image', url: '/path/to/file.pdf')
      @attachment = mock_model(Attachment, attachment: @image, image?: false,
                               created_at: Time.now, comments: [],
                               filename: '/path/to/file.pdf',
                               user: @user, folder: mock_model(Folder))
      do_render
    end 

    it 'shows the file thumb' do 
      expect(rendered).to have_selector('img[src="/assets/file.png"]')
    end 

    it 'shows the filename' do 
      expect(rendered).to have_selector('a', text: '/path/to/file.pdf')
    end 

    it 'links to the file' do 
      expect(rendered).to have_selector('a[href="/path/to/file.pdf"]')
    end 

    it 'shows a discuss link' do
      expect(rendered).to have_selector('a', text: 'discuss')
    end
  end
end
