module Scratch
  class Renderer
    class Window < Gosu::Window

      BACKDROP_ROOT = File.expand_path('../../../../media/backdrops', __FILE__)

      def initialize(stage)
        super(480, 360, true)
        @stage = stage
        @backdrops = {}
      end

      def draw
        backdrop(@stage.backdrop).draw(0, 0, 0)
      end

      def backdrop(filename = nil)
        @backdrops[filename] ||= begin
          full_filename = File.expand_path(filename, BACKDROP_ROOT)
          Gosu::Image.new(self, full_filename, false)
        end
      end

    end
  end
end
