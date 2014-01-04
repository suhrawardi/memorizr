require 'spec_helper'

describe Quote do
  describe 'validation' do
    before do
      @user = mock_model(User)
      @quote = Quote.new(body: '<p>body</p>', user: @user)
    end

    it 'should be valid' do
      @quote.should be_valid
    end

    it 'should be valid without a body' do
      @quote.body = nil
      @quote.should be_valid
    end

    it 'should not be valid without a user' do
      @quote.user = nil
      @quote.should_not be_valid
    end
  end

  describe 'associations' do
    before do
      @quote = Quote.new(body: '<p>body</p>')
    end

    it 'should have a web_page' do
      @quote.should respond_to :web_page
    end

    it 'should have a user' do
      @quote.should respond_to :user
    end
  end

  describe 'with a page' do
    before do
      user = User.new
      params = {user: user, body: '<p>text</p>',
                url: 'http://nu.nl/thing', title: 'a title'}
      @quote = Quote.create_with_page(params)
    end

    it 'has a title' do
      expect(@quote.title).to eq('a title')
    end

    it 'has an url' do
      expect(@quote.url).to eq('http://nu.nl/thing')
    end
  end

  describe 'without a page' do
    before do
      @quote = Quote.new
    end

    it 'has a title' do
      expect(@quote.title).to be_nil
    end

    it 'has an url' do
      expect(@quote.url).to be_nil
    end
  end

  describe 'create_with_page' do
    before do
      @user = User.new
      @params = {user: @user, body: '<p>text</p>',
                 url: 'http://nu.nl/blah/die/bloem', title: 'Url Title'}
    end

    it 'should add a note' do
      lambda do
        Quote.create_with_page(@params)
      end.should change(Quote, :count).by(1)
    end

    it 'should add a page' do
      lambda do
        Quote.create_with_page(@params)
      end.should change(WebPage, :count).by(1)
    end

    describe 'sanitize html' do
      it 'should strip unwanted html tags from the body' do
        body = '<div>with some more text</div>
                <input type="hidden" />'
        @quote = Quote.create_with_page(@params.merge(body: body))
        @quote.body.should == "<p>with some more text</p>"
      end

      it 'should strip unwanted html tags from the body' do
        body = 'with <a onclick="this.submit()">some more</a> text'
        @quote = Quote.create_with_page(@params.merge(body: body))
        @quote.body.should_not =~ /this.submit/
      end

      it 'should remove comments from the body' do
        body = '<p>just <!-- comment -->plain text</p><!-- with another one -->'
        @quote = Quote.create_with_page(@params.merge(body: body))
        @quote.body.should == '<p>just plain text</p>'
      end

      it 'should add the root to an image src' do
        body = 'just text and <img src="/icon.png" /> and text'
        @quote = Quote.create_with_page(@params.merge(body: body))
        @quote.body.should =~ /http:\/\/nu.nl\/icon.png/
      end

      it 'removes the noscript tags content' do
        body = '<li><img src="LRG.jpg"><noscript>NOSCRIPT</noscript></li>'
        @quote = Quote.create_with_page(@params.merge(body: body))
        expect(@quote.body).not_to match(/NOSCRIPT/)
      end

      describe 'absolute links' do
        it 'should add the base url to a link without a base url' do
          body = 'just <a href="/home">a link</a> and text'
          @quote = Quote.create_with_page(@params.merge(body: body))
          @quote.body.should =~ /http:\/\/nu.nl\/home/
        end

        it 'should not add the base url to an absolute https link' do
          body = 'just <a href="https://nu.nl/home">a link</a> and text'
          @quote = Quote.create_with_page(@params.merge(body: body))
          @quote.body.should_not =~ /https:\/\/nu.nl\/home\/https:/
        end

        it 'should add the root to a link with only get variables' do
          body = 'just <a href="?pid=35661&LabelID=17092">vars</a>'
          @quote = Quote.create_with_page(@params.merge(body: body))
          @quote.body.should =~ /http:\/\/nu.nl\/\?pid=35661&amp;LabelID=17092/
        end

        it 'should add the root to a link with only get variables' do
          body = 'an <img src="alonso.jpg"/>.'
          @quote = Quote.create_with_page(@params.merge(body: body))
          @quote.body.should =~ /http:\/\/nu.nl\/blah\/die\/alonso.jpg/
        end
      end
    end
  end

  describe 'save' do
    before do
      @user = User.new
      @params = {user: @user, body: '<p>text</p>',
                 url: 'http://nu.nl', title: 'Url Title'}
      @quote = Quote.create_with_page(@params)
      @quote.stub(:attachment_changed?).and_return(false)
    end

    describe 'sanitize html' do
      it 'should strip unwanted html tags from the body' do
        body = '<div>with some more text</div>
                <input type="hidden" />'
        @quote.update_attributes(body: body)
        @quote.body.should == "<p>with some more text</p>"
      end

      it 'should not strip a span' do
        body = '<span>with some more text</span>'
        @quote.update_attributes(body: body)
        @quote.save!
        @quote.body.should == "<span>with some more text</span>"
      end

      it 'should not strip a class' do
        body = '<p class="highlight">with some more text</p>'
        @quote.update_attributes(body: body)
        @quote.save!
        @quote.body.should == '<p class="highlight">with some more text</p>'
      end
    end
  end
end
