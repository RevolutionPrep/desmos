module Desmos
  class Whiteboard
    include RequestSupport
    attr_accessor :hash, :title, :tutor, :students

    def self.find(hash)
      new(:hash => hash).get
    end

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
      if parsed_response.fetch(:success) == 'false'
        raise RequestError, parsed_response[:error_message] unless parsed_response[:error_message] == 'whiteboard already exists'
      else
        self.hash = parsed_response.fetch(:hash)
      end
      set_tutor
      add_students
      self
    end

    def set_tutor
      if tutor
        parsed_response = request!(:whiteboard, :set_tutor, tutor.request_options.reject { |k,v| k == :user_type }.merge(:whiteboard_hash => hash))
      end
    end

    def add_students
      unless students.empty?
        students.each do |student|
          add_student(student)
        end
      end
    end

    def add_student(student)
      parsed_response = request!(:whiteboard, :add_student, student.request_options.reject { |k,v| k == :user_type }.merge(:whiteboard_hash => hash))
    end

    def get
      parsed_response = request!(:whiteboard, :read, :whiteboard_hash => hash)
      if parsed_response[:success] == 'false'
        case parsed_response[:error_message]
        when 'Whiteboard not found'
          raise WhiteboardNotFound, "Whiteboard with HASH=#{hash} could not be found"
        else
          raise RequestError, parsed_response[:error_message]
        end
      else
        build_from_hash(parsed_response)
      end
    end

    def request_options
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

    def build_from_hash(options)
      self.hash     = options[:hash]
      self.title    = options[:title]
      self.tutor    = Tutor.build_from_hash(options[:tutor])
      self.students = options[:students].collect { |student_attributes| Student.new(student_attributes) }
      self
    end

  end
end
