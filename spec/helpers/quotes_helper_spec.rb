require 'spec_helper'

describe QuotesHelper do

  describe 'the show_oembed helper' do

    it 'should embed a flickr image' do
      url = 'http://www.flickr.com/photos/shapour/2518533790/'
      helper.show_oembed(url).should have_selector('img')
    end

    it 'should embed a youtube movie' do
      url = 'http://www.youtube.com/watch?v=DNYDyXn6qso'
      helper.show_oembed(url).should have_selector('iframe')
    end

    it 'should embed nothing for a non embeddable page' do
      url = 'http://www.amazon.com/ref=gno_logo'
      helper.show_oembed(url).should be_empty
    end  
  end

end
