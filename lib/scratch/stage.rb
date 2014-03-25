module Scratch
  class Stage

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

    def sprites
      @sprites ||= []
    end

    def show
      Scratch::Renderer.new(self).render
    end

    private

    def add_sprite(s)
      sprites << s
    end

  end
end
