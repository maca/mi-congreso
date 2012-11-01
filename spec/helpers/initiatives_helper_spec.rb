# encoding: UTF-8

require 'spec_helper'

describe InitiativesHelper do

  let(:initiative) { mock_model(Initiative, subjects: []) }

  def subject(name)
    mock(:subject, name: name)
  end

  describe "#subjects" do
    it "generates a html tag for every subject" do
      initiative.stub(:subjects) { [subject("Eleccion"), subject("Seguridad")] }
      helper.subjects(initiative, class: "l", tag: "p").should eq '<p class="l">Eleccion</p><p class="l">Seguridad</p>'
    end

    it "returns nothing when subjects are empty" do
      initiative.stub(:subjects) { [] }
      helper.subjects(initiative, class: "l", tag: "p").should be_nil
    end
  end

  describe "#link_to_sort" do
    it "links to the initiatives path with the sorting option" do
      helper.should_receive(:link_to).with("recent", "/iniciativas?order=views_count", {class: "sort"})
      helper.link_to_sort("recent", "views_count", {class: "sort"})
    end

    it "links to the initiatives_subjects path when filtered by subject" do
      helper.stub(:params) { {subject_id: 1} }
      helper.should_receive(:link_to).with("recent", "/iniciativas/temas/1?order=views_count", {})
      helper.link_to_sort("recent", "views_count")
    end

    it "adds a active class" do
      helper.stub(:params) { {order: "views_count"} }
      helper.should_receive(:link_to).with("recent", "/iniciativas?order=views_count", {class: "sort active"})
      helper.link_to_sort("recent", "views_count", {class: "sort"})
    end
  end

  describe "#link_to_sponsors" do
    let(:member) { mock_model(Member, id: 1, name: "Andres") }

    before(:each) do
      initiative.stub(:sponsors_count) { 0 }
      initiative.stub(:member) { member }
    end

    it "generates a link to the member profile" do
      helper.should_receive(:link_to).with("Andres", member)
      helper.link_to_sponsors(initiative)
    end

    it "generates a link with the sponsors_count" do
      initiative.stub(:sponsors_count) { 2 }
      helper.should_receive(:link_to).with("Andres y 2 más", member)
      helper.link_to_sponsors(initiative)
    end
  end

  describe "#votes_width" do
    context "initiative hasn't been votes" do
      before { initiative.stub(:has_been_voted?) { false } }

      it "returns 0.50 for votes for" do
        helper.votes_width(initiative, :for).should eq 50
      end

      it "returns 0.40 for votes against" do
        helper.votes_width(initiative, :against).should eq 40
      end

      it "returns 0.10 for votes neutral" do
        helper.votes_width(initiative, :neutral).should eq 10
      end
    end

    context "it has been voted" do
      before { initiative.stub(:has_been_voted?) { true } }

      it "returns the percentage_votes" do
        initiative.stub(:percentage_votes).with(:for) { 0.30 }
        helper.votes_width(initiative, :for).should eq 30
      end
    end
  end
end
