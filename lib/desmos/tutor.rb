module Desmos
  class Tutor
    attr_accessor :id, :hash, :name

    def initialize(options = {})
      options.symbolize_keys!
      @id   = options[:id]
      @hash = options[:hash]
      @name = options[:name]
    end

  end
end