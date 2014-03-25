require 'spec_helper'

describe Scratch::Stage do
  
  it "should pass" do
    expect(1).to eq(1)
  end

  let(:renderer) do
    Scratch::Renderer.any_instance
  end

  before do
    renderer.stub(:render)
  end

  describe "::new" do

    context "if a block is given" do
      it "should yield self" do
        expect { |b|
          described_class.new(&b)
        }.to yield_with_args(described_class)
      end

      it "should render the stage using the renderer" do
        renderer.should_receive(:render)
        described_class.new { |s| }
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

  describe "#show" do
    it "should render the stage using the renderer" do
      renderer.should_receive(:render)
      subject.show
    end
  end

  describe "#backdrop" do
    context "without any arguments" do
      context "when there is no backdrops set" do
        it "should return nil" do
          expect(subject.backdrop).to be_nil
        end
      end

      context "when there is only one backdrop set" do
        before do
          subject.backdrop "nature/woods"
        end

        it "should return the backdrop" do
          expect(subject.backdrop).to eq("nature/woods")
        end
      end

      context "when there are more than one backdrops set" do
        before do
          subject.backdrop "outdoors/school1"
          subject.backdrop "outdoors/school2"
        end

        it "should return the first one set" do
          expect(subject.backdrop).to eq("outdoors/school1")
        end
      end
    end

    context "with an argument" do
      it "should add the backdrop to the list of backdrops" do
        subject.backdrop "nature/woods"
        expect(subject.backdrops).to eq(['nature/woods'])
      end

      it "should support having more than one backdrop" do
        subject.backdrop "outdoors/school1"
        subject.backdrop "outdoors/school2"
        expect(subject.backdrops).
            to eq(['outdoors/school1', 'outdoors/school2'])
      end
    end
  end

end
