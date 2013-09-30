require 'spec_helper'

describe BuyRequestsController do

  def valid_attributes
    { "email" => "MyString", "name" => "Paul Ser" }
  end

  describe "GET new" do
    it "assigns a new buy_request as @buy_request" do
      get :new, {locale: :ru}
      assigns(:buy_request).should be_a_new(BuyRequest)
    end
  end


  describe "POST create" do
    describe "with valid params" do
      it "creates a new BuyRequest" do
        expect {
          post :create, {locale: :ru, :buy_request => valid_attributes}
        }.to change(BuyRequest, :count).by(1)
      end

      it "assigns a newly created buy_request as @buy_request" do
        post :create, {locale: :ru, :buy_request => valid_attributes}
        assigns(:buy_request).should be_a(BuyRequest)
        assigns(:buy_request).should be_persisted
      end

      it "redirects to the created buy_request" do
        post :create, {locale: :ru, :buy_request => valid_attributes}
        expect(response.code).to eq("200")
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved buy_request as @buy_request" do
        # Trigger the behavior that occurs when invalid params are submitted
        BuyRequest.any_instance.stub(:save).and_return(false)
        post :create, {locale: :ru, :buy_request => { "email" => "invalid value" }}
        assigns(:buy_request).should be_a_new(BuyRequest)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        BuyRequest.any_instance.stub(:save).and_return(false)
        post :create, {locale: :ru, :buy_request => { "email" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

end
