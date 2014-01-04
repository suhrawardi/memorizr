require 'spec_helper'

describe UriHelper do

  describe 'for an invalid uri' do
    before do 
      @helper = UriHelper.new('index.php?pg=13&sj=Intangible heritage&sp=13')
    end

    it 'returns nil for scheme' do
      expect(@helper.scheme).to be_nil
    end

    it 'returns nil for host' do
      expect(@helper.host).to be_nil
    end

    it 'returns nil for path' do
      expect(@helper.path).to be_nil
    end

    it 'returns nil for query string' do
      expect(@helper.query).to be_nil
    end
  end

  describe 'for a valid uri' do
    before do 
      @helper = UriHelper.new('https://www.nu.nl/een/twee/imghp?hl=nl&tab=wi')
    end

    it 'returns the scheme' do
      expect(@helper.scheme).to eq('https')
    end

    it 'returns the host' do
      expect(@helper.host).to eq('www.nu.nl')
    end

    it 'returns the path' do
      expect(@helper.path).to eq('/een/twee/imghp')
    end

    it 'returns the query string' do
      expect(@helper.query).to eq('hl=nl&tab=wi')
    end
  end
end
