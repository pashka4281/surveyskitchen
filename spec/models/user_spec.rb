require 'spec_helper'

describe User do
  context "creating" do

    it "should create an account for non-invited users" do
      u = FactoryGirl.create(:user, account_name: 'Microsoft', full_name: "Dan Martel")
      u.owned_account.should_not be_nil
    end

    it "should include user into his newly created account" do
      u = FactoryGirl.create(:user, account_name: 'Microsoft', full_name: "Dan Martel")
      u.owned_account.users.should include(u)
    end

  end
end
