require 'spec_helper'

describe Scratch::Stage do
  
  it "should pass" do
    expect(1).to eq(1)
  end

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

  describe "#sprite" do

    context "when a block is given" do
      
      it "should yield a new sprite instance" do
        expect { |b|
          subject.sprite(&b)
        }.to yield_with_args(Scratch::Sprite)
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
