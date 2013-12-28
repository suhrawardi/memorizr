require 'spec_helper'

describe Page do
  describe 'validation' do
    subject(:page) do
      Page.new(body: 'Page body', title: 'Page title')
    end

    it 'should be valid' do
      expect(page).to be_valid
    end

    it 'is not valid without a title' do
      page.title = nil
      expect(page).not_to be_valid
    end

    it 'is not valid without a body' do
      page.body = nil
      expect(page).not_to be_valid
    end
  end

  describe 'callbacks' do

    describe 'make_parameter' do

      it 'creates a parameter' do
        page = Page.create!(body: 'Page body', title: "The Page's Title")
        expect(page.parameter).to eq('the-page-s-title')
      end
    end
  end
end
