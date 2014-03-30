require 'spec_helper'

describe UnitsHelper do

  describe 'add_tag_js' do

    it 'should return the add tag js for a quote' do
      unit = stub_model(Quote)
      helper.add_tag_js(unit).should =~ /^quote_/
    end

    it 'should return the add tag js for a note' do
      unit = stub_model(Note)
      helper.add_tag_js(unit).should =~ /^note_/
    end
  end
end
