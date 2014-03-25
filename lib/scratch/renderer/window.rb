module Scratch
  class Renderer
    class Window < Gosu::Window

      BACKDROP_ROOT = File.expand_path('../../../../media/backdrops', __FILE__)

      COSTUMES_ROOT = File.expand_path('../../../../media/costumes', __FILE__)

      def initialize(stage)
        super(480, 360, true)
        @stage = stage
        @backdrops = {}
        @costumes = {}
      end

      def draw
        backdrop(@stage.backdrop).draw(0, 0, 0)
        @stage.sprites.each do |sprite|
          costume(sprite.costume).draw(0, 0, 0)
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
