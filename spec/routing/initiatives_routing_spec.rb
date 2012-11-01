require "spec_helper"

describe "routing to initiatives" do

  it "routes /iniciativas to initiatives#index" do
    get("/iniciativas").should route_to(controller: "initiatives", action: "index")
  end

  it "routes /iniciativas/:id to initiatives#show" do
    get("/iniciativas/1").should route_to(controller: "initiatives", action: "show", id: "1")
  end
end