module Desmos
  class Tutor < User

    def initialize(options = {})
      super
      @type = 'tutor'
    end

  end
end