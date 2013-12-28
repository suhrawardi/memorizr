require 'spec_helper'

describe WebPage do
  describe 'validation' do
    before do
      @page = WebPage.new(url: 'http://nu.nl', title: 'Title')
    end

    it 'should be valid' do
      @page.should be_valid
    end

    describe 'url validation' do

      it 'should be valid without an url' do
        @page.url = nil
        @page.should be_valid
      end

      it 'should not be valid with an invalid scheme' do
        @page.url = 'ftp://jarra@ftp.nu.nl'
        @page.should_not be_valid
      end

      it 'should not be valid without a host' do
        @page.url = 'http:///path/to/something'
        @page.should_not be_valid
      end
    end
  end

  describe 'associations' do
    before do
      @page = WebPage.new(url: 'http://nu.nl', title: 'Title')
    end

    it 'should have a note' do
      @page.should respond_to :note
    end

    it 'should have a user' do
      @page.should respond_to :user
    end
  end

  describe 'url' do
    before do 
      @page = WebPage.new(url: 'https://www.google.nl/imghp?hl=nl&tab=wi')
    end

    it 'should return the scheme' do
      expect(@page.scheme).to eq('https')
    end

    it 'should return the host' do
      expect(@page.host).to eq('www.google.nl')
    end

    it 'should return the path' do
      expect(@page.path).to eq('/imghp')
    end

    it 'should return the query string' do
      expect(@page.query).to eq('hl=nl&tab=wi')
    end

    it 'should return the root' do
      expect(@page.root).to eq('https://www.google.nl')
    end
  end
end
