module Desmos
  class Whiteboard
    include RequestSupport
    attr_accessor :hash, :title, :tutor, :students

    def self.find(hash)
      new(:hash => hash).find
    end

    def self.create(options = {})
      new(options).save
    end

    def initialize(options = {})
      @hash       = options[:hash]           # optional: The API will generate this if not provided. Must be unique if provided.
      @title      = options[:title]          # optional
      @tutor      = options[:tutor]          # optional: Should be a Desmos::Tutor object
      @students   = options[:students] || [] # optional: Should be an Array of Desmos::Student objects
    end

    def save
      parsed_response = request!(:whiteboard, :create, request_options)
      self.hash = parsed_response.fetch(:hash)
      self
    end

    def find
      parsed_response = request!(:whiteboard, :read, :whiteboard_hash => hash)
      build_from_hash(parsed_response)
      self
    end

    def request_options
      @request_options ||= begin
        options = {}
        options.merge!(:hash       => hash)  if hash
        options.merge!(:title      => title) if title
        if tutor
          options.merge!(:tutor_name => tutor.name) if tutor.name
          options.merge!(:tutor_id   => tutor.id)   if tutor.id
          options.merge!(:tutor_hash => tutor.hash) if tutor.hash
        end
        options
      end
    end

    def build_from_hash(options)
      self.hash     = options[:hash]
      self.title    = options[:title]
      self.tutor    = Tutor.new(options[:tutor])
      self.students = options[:students].collect { |student_attributes| Student.new(student_attributes) }
    end

  end
end