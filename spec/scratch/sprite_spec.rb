require 'spec_helper'

describe Scratch::Sprite do
  
  describe "::new" do
    
    context "if a block is given" do
      it "should yield self" do
        yielded = false
        described_class.new do |stage|
          expect(stage).to be_a(described_class)
          yielded = true
        end
        expect(yielded).to eq(true)
      end
    end

    context "if no block is given" do

      it "should return a stage instance" do
        stage = described_class.new
        expect(stage).to be_a(described_class)
      end

    end

  end

end
