# frozen_string_literal: false

require('rails_helper')

RSpec.describe('routes for Accounts', type: :routing) do
    it "routes /accounts to accounts#index" do
        expect(get: "/accounts").to route_to(
        controller: "accounts",
        action: "index"
        )
    end
    
    it "routes /accounts/1 to accounts#show" do
        expect(get: "/accounts/1").to route_to(
        controller: "accounts",
        action: "show",
        id: "1"
        )
    end
    
    it "routes /accounts/new to accounts#new" do
        expect(get: "/accounts/new").to route_to(
        controller: "accounts",
        action: "new"
        )
    end
    
    it "routes /accounts to accounts#create" do
        expect(post: "/accounts").to route_to(
        controller: "accounts",
        action: "create"
        )
    end
    
    it "routes /accounts/1/edit to accounts#edit" do
        expect(get: "/accounts/1/edit").to route_to(
        controller: "accounts",
        action: "edit",
        id: "1"
        )
    end
    
    it "routes /accounts/1 to accounts#update" do
        expect(put: "/accounts/1").to route_to(
        controller: "accounts",
        action: "update",
        id: "1"
        )
        expect(patch: "/accounts/1").to route_to(
        controller: "accounts",
        action: "update",
        id: "1"
        )
    end
    
    it "routes /accounts/1 to accounts#destroy" do
        expect(delete: "/accounts/1").to route_to(
        controller: "accounts",
        action: "destroy",
        id: "1"
        )
    end
end  
