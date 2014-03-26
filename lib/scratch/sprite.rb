module Scratch
  class Sprite

    def initialize
      @when_game_starts_blocks = []
      @costume_id = 0
      @position = { :x => 0, :y => 0 }
      if block_given?
        yield self
      end
    end

    def costume(c = nil)
      if c.is_a?(String)
        costumes << c
      elsif c.nil?
        if costumes.any?
          costumes[@costume_id]
        else
          nil
        end
      end
    end

    def costumes
      @costumes ||= []
    end

    def next_costume
      return unless costumes.any?
      @costume_id = (@costume_id + 1) % costumes.length
    end

    def move(steps)
      @position[:x] += steps
    end

    def when_game_starts(&b)
      unless block_given?
        raise ArgumentError.new("I need an action to do")
      end
      @when_game_starts_blocks << b
    end

    def x
      @position[:x]
    end

    def y
      @position[:y]
    end

    def _game_starts
      @when_game_starts_blocks.each do |b|
        Thread.new do
          b.call
        end
      end
    end

  end
end
