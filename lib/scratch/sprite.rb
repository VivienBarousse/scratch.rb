module Scratch
  class Sprite

    def initialize
      @when_game_starts_blocks = []
      @costume_id = 0
      @position = { :x => 0, :y => 0 }
      @direction = 90

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

    def direction
      @direction
    end

    def direction=(d)
      while d <= -180
        d += 360
      end
      while d > 180
        d -= 360
      end
      @direction = d
    end

    def move(steps)
      dx = Math.cos(direction_rad) * steps
      dy = Math.sin(direction_rad) * steps
      @position[:x] += dx.round
      @position[:y] += dy.round
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

    private

    def direction_rad
      (direction.to_f - 90.0) / -180.0 * Math::PI
    end

  end
end
