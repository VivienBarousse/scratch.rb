module Scratch
  class Sprite

    def initialize
      if block_given?
        yield self
      end
    end

  end
end
