module Scratch
  class Sprite

    def initialize
      @when_game_starts_blocks = []
      if block_given?
        yield self
      end
    end

    def costume(c = nil)
      if c.is_a?(String)
        costumes << c
      elsif c.nil?
        if costumes.any?
          costumes.first
        else
          nil
        end
      end
    end

    def costumes
      @costumes ||= []
    end

    def when_game_starts(&b)
      unless block_given?
        raise ArgumentError.new("I need an action to do")
      end
      @when_game_starts_blocks << b
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
