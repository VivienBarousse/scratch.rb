require 'spec_helper'

describe Scratch::Renderer do

  let(:stage) do
    double(:stage)
  end

  before do
    stage.stub(:is_a?).with(Scratch::Stage).and_return(true)
  end

  subject do
    described_class.new(stage)
  end

  describe "::new" do
    context "when I pass wrguments of the wrong type" do
      it "should raise an error" do
        expect {
          described_class.new(1)
        }.to raise_error(ArgumentError)
      end
    end
  end

end
