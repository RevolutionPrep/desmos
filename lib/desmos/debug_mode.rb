module Desmos
  module DebugMode
    
    def debug(msg)
      puts msg if Configuration.debug_mode
    end
    
  end
end