require 'spec_helper'

describe ApplicationHelper do

  describe 'show_flash' do
    before do
      @flash = {}
      helper.stub(:flash).and_return(@flash)
    end

    it 'should not display anything' do
      helper.show_flash.should be_empty
    end

    it 'should display an error when given' do
      @flash[:error] = 'erratic'
      helper.show_flash.should have_selector('div.error', text: 'erratic')
    end

    it 'should display a notice when given' do
      @flash[:notice] = 'note'
      helper.show_flash.should have_selector('div.notice', text: 'note')
    end
  end

  describe 'to_flash_msg' do

    it 'should return a neat alert message' do
      result = '<div class="alert alert-info alert">Watch out!</div>'
      helper.to_flash_msg(:alert, 'Watch out!').should == result
    end
  end

  describe 'show_js_msg' do

    it 'should return JS with the alert' do
      result = "showJsMsg('alert', 'Watch out!');"
      helper.show_js_msg(:alert, 'Watch out!').should == result
    end

    it 'should return JS with the alert' do
      result = "showJsMsg('message', 'Notified!');"
      helper.show_js_msg(:message, 'Notified!').should == result
    end
  end
end
