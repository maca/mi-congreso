require "spec_helper"

describe "routing to deputies" do

  it "routes /diputados to deputies#index" do
    get("/diputados").should route_to(controller: "deputies", action: "index")
  end

  it "routes /diputados/:id to deputies#show" do
    get("/diputados/1").should route_to(controller: "deputies", action: "show", id: "1")
  end
end