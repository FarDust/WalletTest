# frozen_string_literal: false

require('rails_helper')

RSpec.describe('routes for Accounts', type: :routing) do
    it "routes /accounts/1/movements to movements#index" do
        expect(get: "/accounts/1/movements").to route_to(
        controller: "movements",
        action: "index",
        account_id: "1"
        )
    end
    
    it "routes /accounts/1/movements/1 to movements#show" do
        expect(get: "/accounts/1/movements/1").to route_to(
        controller: "movements",
        action: "show",
        account_id: "1",
        id: "1"
        )
    end
    
    it "routes /accounts/1/movements/new to movements#new" do
        expect(get: "/accounts/1/movements/new").to route_to(
        controller: "movements",
        action: "new",
        account_id: "1"
        )
    end
    
    it "routes /accounts/1/movements to movements#create" do
        expect(post: "/accounts/1/movements").to route_to(
        controller: "movements",
        action: "create",
        account_id: "1"
        )
    end
    
    it "routes /accounts/1/movements/1/edit to movements#edit" do
        expect(get: "/accounts/1/movements/1/edit").to route_to(
        controller: "movements",
        action: "edit",
        account_id: "1",
        id: "1"
        )
    end
    
    it "routes /accounts/1/movements/1 to movements#update" do
        expect(put: "/accounts/1/movements/1").to route_to(
        controller: "movements",
        action: "update",
        account_id: "1",
        id: "1"
        )
        expect(patch: "/accounts/1/movements/1").to route_to(
        controller: "movements",
        action: "update",
        account_id: "1",
        id: "1"
        )
    end
    
    it "routes /accounts/1/movements/1 to movements#destroy" do
        expect(delete: "/accounts/1/movements/1").to route_to(
        controller: "movements",
        action: "destroy",
        account_id: "1",
        id: "1"
        )
    end
end  