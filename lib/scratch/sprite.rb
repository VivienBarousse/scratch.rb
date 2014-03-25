module Scratch
  class Sprite

    def initialize
      if block_given?
        yield self
      end
    end

    def costume(c = nil)
      if c.is_a?(String)
        costumes << c
      elsif c.nil?
        if costumes.any?
          costumes.first
        else
          nil
        end
      end
    end

    def costumes
      @costumes ||= []
    end

  end
end
