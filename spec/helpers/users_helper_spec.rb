require 'spec_helper'

describe UsersHelper do

  describe 'link_to_user' do

    let(:user) do
      stub_model(User, name: 'Jopie')
    end

    it "returns the link to a user's units page" do
      expect(helper.link_to_user(user)).to have_selector('a', text: 'Jopie')
    end

    it 'has the correct link' do
      xpath = "//a[@href='/users/#{user.id}/units']"
      expect(helper.link_to_user(user)).to have_xpath(xpath)
    end
  end
end
