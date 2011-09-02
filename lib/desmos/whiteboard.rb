module Desmos
  class Whiteboard
    include RequestSupport
    attr_accessor :hash, :title, :tutor, :students

    # def self.find(hash)
    #   new(:hash => hash).find
    # end

    def self.create(options = {})
      new(options).save
    end

    def initialize(options = {})
      @hash       = options[:hash]  # optional: The API will generate this if not provided. Must be unique if provided.
      @title      = options[:title] # optional


      # optional: Should be a Desmos::Tutor object
      if options[:tutor] && !(Tutor === options[:tutor])
        raise ArgumentError, ':tutor option must be either of type Desmos::Tutor or NilClass'
      end
      @tutor = options[:tutor]

      # optional: Should be an Array of Desmos::Student objects
      if options[:students] && (!options[:students].respond_to?(:all?) || !options[:students].all? { |option| Desmos::Student === option })
        raise ArgumentError, ':students option must be either an Array containing object of type Desmos::Student or NilClass'
      end
      @students = options[:students] || []
    end

    def save
      parsed_response = request!(:whiteboard, :create, request_options)
      self.hash = parsed_response.fetch(:hash)
      self
    end

    # def find
    #   parsed_response = request!(:whiteboard, :read, :whiteboard_hash => hash)
    #   build_from_hash(parsed_response)
    #   self
    # end

    def request_options
      @request_options ||= begin
        options = {}
        options.merge!(:hash  => hash)  if hash
        options.merge!(:title => title) if title
        if tutor
          options.merge!(:tutor_name => tutor.name) if tutor.name
          options.merge!(:tutor_id   => tutor.id)   if tutor.id
          options.merge!(:tutor_hash => tutor.hash) if tutor.hash
        end
        options
      end
    end

    # def build_from_hash(options)
    #   self.hash     = options[:hash]
    #   self.title    = options[:title]
    #   self.tutor    = Tutor.new(options[:tutor])
    #   self.students = options[:students].collect { |student_attributes| Student.new(student_attributes) }
    # end

  end
end