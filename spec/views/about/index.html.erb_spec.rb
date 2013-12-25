require 'spec_helper'

describe "about/index.html.erb" do
  before do 
    view.stub(:current_user).and_return(mock_model(User))
  end 
 
  it 'should render' do 
    render :template => 'about/index', :handlers => [:erb] 
    rendered.should have_selector('body')
  end 
end
