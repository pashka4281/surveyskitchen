require "spec_helper"

describe BuyRequestsController do
  describe "routing" do

    it "routes to #index" do
      get("/buy_requests").should route_to("buy_requests#index")
    end

    it "routes to #new" do
      get("/buy_requests/new").should route_to("buy_requests#new")
    end

    it "routes to #show" do
      get("/buy_requests/1").should route_to("buy_requests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/buy_requests/1/edit").should route_to("buy_requests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/buy_requests").should route_to("buy_requests#create")
    end

    it "routes to #update" do
      put("/buy_requests/1").should route_to("buy_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/buy_requests/1").should route_to("buy_requests#destroy", :id => "1")
    end

  end
end
