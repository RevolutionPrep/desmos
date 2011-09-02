require 'active_support/core_ext/hash/keys'
require 'oauth'
require 'yajl'

module Desmos
  autoload :Configuration,  'desmos/configuration'
  autoload :DebugMode,      'desmos/debug_mode'
  autoload :RequestSupport, 'desmos/request_support'
  autoload :Student,        'desmos/student'
  autoload :Tutor,          'desmos/tutor'
  autoload :Utils,          'desmos/utils'
  autoload :Whiteboard,     'desmos/whiteboard'

  # ERROR CLASSES
  autoload :ConfigurationError, 'desmos/errors'
  autoload :RequestError,       'desmos/errors'
end