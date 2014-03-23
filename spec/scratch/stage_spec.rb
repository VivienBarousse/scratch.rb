require 'spec_helper'

describe Scratch::Stage do
  
  it "should pass" do
    expect(1).to eq(1)
  end

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

  describe "#sprite" do

    context "when a block is given" do
      
      it "should yield a new sprite instance" do
        yielded = false
        subject.sprite do |sprite|
          expect(sprite).to be_a(Scratch::Sprite)
          yielded = true
        end
        expect(yielded).to eq(true)
      end

    end

    context "when no block is given" do
      
      it "should return a sprite instance" do
        sprite = subject.sprite
        expect(sprite).to be_a(Scratch::Sprite)
      end

    end

    it "should add the sprite to the list of sprites on the stage" do
      expect(subject.sprites.length).to be(0)
      subject.sprite
      expect(subject.sprites.length).to be(1)
      subject.sprite
      expect(subject.sprites.length).to be(2)
    end

  end

end
