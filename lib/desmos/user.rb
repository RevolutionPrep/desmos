module Desmos
  class User
    attr_accessor :id, :hash, :type, :name, :last_name, :family_name, :skype, :email

    def initialize(options = {})
      options.symbolize_keys!
      @type        = 'user'
      @hash        = options[:hash]
      @last_name   = options[:last_name]
      @family_name = options[:family_name]
      @skype       = options[:skype]
      @email       = options[:email]

      raise ArgumentError, ':id is a required attribute' unless options[:id]
      @id = options[:id]

      raise ArgumentError, ':name is a required attribute' unless options[:name]
      @name = options[:name]
    end

    def self.build_from_hash(options = {})
      return if options[:id].blank?
      return if options[:name].blank?
      new(options)
    end

  end
end