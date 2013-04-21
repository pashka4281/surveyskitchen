require 'spec_helper'

describe "buy_requests/index" do
  before(:each) do
    assign(:buy_requests, [
      stub_model(BuyRequest,
        :email => "Email",
        :name => "Name",
        :how_found => "How Found",
        :text => "MyText",
        :acc_type => "Acc Type"
      ),
      stub_model(BuyRequest,
        :email => "Email",
        :name => "Name",
        :how_found => "How Found",
        :text => "MyText",
        :acc_type => "Acc Type"
      )
    ])
  end

  it "renders a list of buy_requests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "How Found".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Acc Type".to_s, :count => 2
  end
end
