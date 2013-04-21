require 'spec_helper'

describe "buy_requests/show" do
  before(:each) do
    @buy_request = assign(:buy_request, stub_model(BuyRequest,
      :email => "Email",
      :name => "Name",
      :how_found => "How Found",
      :text => "MyText",
      :acc_type => "Acc Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/Name/)
    rendered.should match(/How Found/)
    rendered.should match(/MyText/)
    rendered.should match(/Acc Type/)
  end
end
