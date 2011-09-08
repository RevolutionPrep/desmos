module Desmos
  class User
    attr_accessor :id, :hash, :type, :name

    def initialize(options = {})
      options.recursive_symbolize_keys!
      @type        = 'user'
      @hash        = options[:hash]

      raise ArgumentError, ':id is a required attribute' unless options[:id]
      @id = options[:id]

      raise ArgumentError, ':name is a required attribute' unless options[:name]
      @name = options[:name]
    end

    def self.build_from_hash(options = {})
      options.recursive_symbolize_keys!
      return if options[:id].blank?
      return if options[:name].blank?
      new(options)
    end

    def request_options
      options = {}
      options.merge!(:user_id   => id)
      options.merge!(:user_name => name)
      options.merge!(:user_type => type)
      options.merge!(:user_hash => hash) if hash
      options
    end

  end
end