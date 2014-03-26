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

  describe "#next_costume" do
    context "when they are no costumes" do
      it "should do nothing, but not raise an error" do
        subject.next_costume
      end
    end

    context "when there is only one costume" do
      it "should not change the costume" do
        subject.costume "a"
        subject.next_costume
        expect(subject.costume).to eq("a")
      end
    end

    context "when there are more than one costume" do
      it "should change to the next costume" do
        subject.costume "a"
        subject.costume "b"
        subject.costume "c"
        expect(subject.costume).to eq('a')
        subject.next_costume
        expect(subject.costume).to eq('b')
        subject.next_costume
        expect(subject.costume).to eq('c')
        subject.next_costume
        expect(subject.costume).to eq('a')
      end
    end
  end

  describe "#when_game_starts" do
    context "when no block is given" do
      it "should raise an error" do
        expect {
          subject.when_game_starts
        }.to raise_error(ArgumentError)
      end
    end

    context "when a block is given" do
      it "should execute it when the game starts" do
        ran = 0
        subject.when_game_starts do
          ran = 1
        end
        subject._game_starts

        # Allow for multithreaded execution
        sleep(0.1)

        expect(ran).to eq(1)
      end
    end

    context "when more than one block are given" do
      it "should execute them all when the game starts" do
        ran = Set.new
        subject.when_game_starts do
          ran << 'a'
        end
        subject.when_game_starts do
          ran << 'b'
        end
        subject._game_starts

        # Allow for multithreaded execution
        sleep(0.1)

        expect(ran).to include('a')
        expect(ran).to include('b')
      end
    end
  end

  describe "#move" do
    context "when I give zero as a value" do
      it "should not move" do
        subject.move(0)
        expect(subject.x).to eq(0)
        expect(subject.y).to eq(0)
      end
    end

    context "with positive values" do
      it "should move on the x axis" do
        subject.move(10)
        expect(subject.x).to eq(10)
        expect(subject.y).to eq(0)
        subject.move(10)
        expect(subject.x).to eq(20)
        expect(subject.y).to eq(0)
      end
    end

    context "with negative values" do
      it "should move on the x axis" do
        subject.move(-10)
        expect(subject.x).to eq(-10)
        expect(subject.y).to eq(0)
        subject.move(-10)
        expect(subject.x).to eq(-20)
        expect(subject.y).to eq(0)
      end
    end

    context "with a mixture of positive and negative values" do
      it "should move on the x axis" do
        subject.move(10)
        expect(subject.x).to eq(10)
        expect(subject.y).to eq(0)
        subject.move(-15)
        expect(subject.x).to eq(-5)
        expect(subject.y).to eq(0)
        subject.move(20)
        expect(subject.x).to eq(15)
        expect(subject.y).to eq(0)
      end
    end
  end

end
