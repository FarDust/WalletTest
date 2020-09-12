require "rails_helper"

RSpec.describe "routes for index", :type => :routing do
  it "routes / to the index controller" do
    expect(get("/")).
      to route_to("index#index")
  end
end