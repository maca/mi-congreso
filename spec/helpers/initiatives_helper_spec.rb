require 'spec_helper'

describe InitiativesHelper do

  let(:initiative) { mock_model(Initiative, subjects: []) }

  def subject(name)
    mock(:subject, name: name)
  end

  describe "#subjects" do
    it "returns the subjects separated by comma" do
      initiative.stub(:subjects) { [subject("Eleccion"), subject("Seguridad")] }
      helper.subjects(initiative).should eq "Eleccion, Seguridad"
    end
  end

  describe "#link_to_sort" do
    it "links to the initiatives path with the sorting option" do
      helper.should_receive(:link_to).with("recent", "/iniciativas?order=views_count", {class: "sort"})
      helper.link_to_sort("recent", "views_count", {class: "sort"})
    end

    it "adds a active class" do
      helper.stub(:params) { {order: "views_count"} }
      helper.should_receive(:link_to).with("recent", "/iniciativas?order=views_count", {class: "sort active"})
      helper.link_to_sort("recent", "views_count", {class: "sort"})
    end
  end
end
