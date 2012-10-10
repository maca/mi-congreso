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
end
