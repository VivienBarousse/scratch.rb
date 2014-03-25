module Scratch
  class Renderer
    class Window < Gosu::Window

      def initialize(stage)
        super(1024, 768, false)
        @stage = stage
      end

    end
  end
end
