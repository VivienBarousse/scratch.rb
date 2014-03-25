require 'spec_helper'

describe Scratch::Sprite do
  
  describe "::new" do
    
    context "if a block is given" do
      it "should yield self" do
        expect { |b|
          described_class.new(&b)
        }.to yield_with_args(described_class)
      end
    end

    context "if no block is given" do

      it "should return a stage instance" do
        stage = described_class.new
        expect(stage).to be_a(described_class)
      end

    end

  end

  describe "#costume" do
    context "without any arguments" do
      context "when there is no costumes set" do
        it "should return nil" do
          expect(subject.costume).to be_nil
        end
      end

      context "when there is only one costume set" do
        before do
          subject.costume "animals/cat1-a"
        end

        it "should return the costume" do
          expect(subject.costume).to eq("animals/cat1-a")
        end
      end

      context "when there are more than one costumes set" do
        before do
          subject.costume "animals/cat1-a"
          subject.costume "animals/cat1-b"
        end

        it "should return the first one set" do
          expect(subject.costume).to eq("animals/cat1-a")
        end
      end
    end

    context "with an argument" do
      it "should add the costume to the list of costumes" do
        subject.costume "animals/cat1-a"
        expect(subject.costumes).to eq(['animals/cat1-a'])
      end

      it "should support having more than one costume" do
        subject.costume "animals/cat1-a"
        subject.costume "animals/cat1-b"
        expect(subject.costumes).
            to eq(['animals/cat1-a', 'animals/cat1-b'])
      end
    end
  end

end
