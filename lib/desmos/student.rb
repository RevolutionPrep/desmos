module Desmos
  class Student < User

    def initialize(options = {})
      super
      @type = 'student'
    end

  end
end