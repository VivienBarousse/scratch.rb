module Scratch
  class Renderer
    class Window < Gosu::Window

      BACKDROP_ROOT = File.expand_path('../../../../media/backdrops', __FILE__)

      COSTUMES_ROOT = File.expand_path('../../../../media/costumes', __FILE__)

      WIDTH = 480
      HEIGHT = 320

      def initialize(stage)
        super(WIDTH, HEIGHT, true)
        @stage = stage
        @backdrops = {}
        @costumes = {}
      end

      def update
        @stage.mouse_x = mouse_x.round - (WIDTH / 2)
        @stage.mouse_y = -1 * (mouse_y.round - (HEIGHT / 2))
      end

      def draw
        backdrop(@stage.backdrop).draw(0, 0, 0)
        @stage.sprites.each do |sprite|
          image = costume(sprite.costume)
          x = sprite.x + (WIDTH / 2)
          y = -sprite.y + (HEIGHT / 2)
          image.draw_rot(x, y, 0, sprite.direction - 90)
        end
      end

      def backdrop(filename)
        @backdrops[filename] ||= begin
          full_filename = File.expand_path(filename, BACKDROP_ROOT)
          Gosu::Image.new(self, full_filename, false)
        end
      end

      def costume(filename)
        @costumes[filename] ||= begin
          full_filename = File.expand_path(filename, COSTUMES_ROOT)
          Gosu::Image.new(self, full_filename, false)
        end
      end

    end
  end
end
