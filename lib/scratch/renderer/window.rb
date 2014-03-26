module Scratch
  class Renderer
    class Window < Gosu::Window

      BACKDROP_ROOT = File.expand_path('../../../../media/backdrops', __FILE__)

      COSTUMES_ROOT = File.expand_path('../../../../media/costumes', __FILE__)

      SAMPLES_ROOT = File.expand_path('../../../../media/sounds', __FILE__)

      WIDTH = 480
      HEIGHT = 320

      def initialize(stage)
        super(WIDTH, HEIGHT, true, 20)
        @stage = stage
        @backdrops = {}
        @costumes = {}
        @samples = {}
      end

      def update
        @stage.mouse_x = mouse_x.round - (WIDTH / 2)
        @stage.mouse_y = -1 * (mouse_y.round - (HEIGHT / 2))

        while @stage._queued_sounds.any?
          file = @stage._queued_sounds.pop
          sample(file).play
        end
      end

      def draw
        backdrop(@stage.backdrop).draw(0, 0, 0)
        @stage.sprites.each do |sprite|
          image = costume(sprite.costume)
          x = sprite.x + (WIDTH / 2)
          y = -sprite.y + (HEIGHT / 2)
          direction = sprite.direction - 90
          scale = sprite.size / 100.0
          image.draw_rot(x, y, 0, direction, 0.5, 0.5, scale, scale)
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

      def sample(filename)
        @samples[filename] ||= begin
          full_filename = File.expand_path(filename, SAMPLES_ROOT)
          Gosu::Sample.new(self, full_filename)
        end
      end

    end
  end
end
