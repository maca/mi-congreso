require "spec_helper"

describe "routing to members" do

  it "routes /diputados to members#index" do
    get("/diputados").should route_to(controller: "members", action: "index")
  end

  it "routes /diputados/:id to members#show" do
    get("/diputados/1").should route_to(controller: "members", action: "show", id: "1")
  end
end