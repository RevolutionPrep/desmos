require 'oauth'
require 'yajl'

module Desmos
  autoload :Configuration,  'desmos/configuration'
  autoload :DebugMode,      'desmos/debug_mode'
  autoload :RequestSupport, 'desmos/request_support'
  autoload :Student,        'desmos/student'
  autoload :Tutor,          'desmos/tutor'
  autoload :User,           'desmos/user'
  autoload :Utils,          'desmos/utils'
  autoload :Whiteboard,     'desmos/whiteboard'

  # ERROR CLASSES
  autoload :ConfigurationError, 'desmos/errors'
  autoload :RequestError,       'desmos/errors'
  autoload :WhiteboardNotFound, 'desmos/errors'
end

require 'desmos/recursive_symbolize_keys'