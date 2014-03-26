module Scratch
  class Stage

    attr_accessor :mouse_x, :mouse_y

    def initialize
      if block_given?
        yield self
        show
      end
    end

    def sprite
      sprite = if block_given?
        Scratch::Sprite.new do |sprite|
          yield sprite
        end
      else
        Scratch::Sprite.new
      end
      add_sprite(sprite)
      sprite
    end

    def backdrop(b = nil)
      if b.is_a?(String)
        backdrops << b
      elsif b.nil?
        if backdrops.any?
          backdrops.first
        else
          nil
        end
      end
    end

    def sprites
      @sprites ||= []
    end

    def backdrops
      @backdrops ||= []
    end

    def show
      Scratch::Renderer.new(self).render
    end

    def _game_starts
      sprites.each do |sprite|
        sprite._game_starts
      end
    end

    private

    def add_sprite(s)
      sprites << s
    end

  end
end
