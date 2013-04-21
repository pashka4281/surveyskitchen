require 'spec_helper'

describe "buy_requests/edit" do
  before(:each) do
    @buy_request = assign(:buy_request, stub_model(BuyRequest,
      :email => "MyString",
      :name => "MyString",
      :how_found => "MyString",
      :text => "MyText",
      :acc_type => "MyString"
    ))
  end

  it "renders the edit buy_request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => buy_requests_path(@buy_request), :method => "post" do
      assert_select "input#buy_request_email", :name => "buy_request[email]"
      assert_select "input#buy_request_name", :name => "buy_request[name]"
      assert_select "input#buy_request_how_found", :name => "buy_request[how_found]"
      assert_select "textarea#buy_request_text", :name => "buy_request[text]"
      assert_select "input#buy_request_acc_type", :name => "buy_request[acc_type]"
    end
  end
end
