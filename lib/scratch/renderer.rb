module Scratch
  class Renderer

    autoload :Window, File.expand_path('../renderer/window.rb', __FILE__)

    def initialize(stage)
      unless stage.is_a?(Scratch::Stage)
        raise ArgumentError.new("Expected a stage, got #{stage.inspect}")
      end

      @stage = stage
    end

    def render
      window = Scratch::Renderer::Window.new(@stage)
      window.show
    end

  end
end
