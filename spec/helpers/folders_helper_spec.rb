require 'spec_helper'

describe FoldersHelper do

  describe 'sanitize_unit' do

    it 'should remove image tags' do
      text = '<p>an <img src="file.png" /> image</p>'
      helper.sanitize_unit(text).should_not =~ /img/
    end
  end
end
