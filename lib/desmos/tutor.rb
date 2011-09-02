module Desmos
  class Tutor
    include RequestSupport
    attr_accessor :id, :hash, :name, :last_name, :family_name, :skype, :email

    def initialize(options = {})
      options.symbolize_keys!
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

    def save
      parsed_response = request!(:users, :create, request_options)
      self
    end

    def request_options
      @request_options ||= begin
        options = {}
        options.merge(:user_id     => id)
        options.merge(:type        => 'tutor')
        options.merge(:name        => name)
        options.merge(:family_name => family_name) if family_name
        options.merge(:last_name   => last_name)   if last_name
        options.merge(:skype       => skype)       if skype
        options.merge(:email       => email)       if email
        options
      end
    end

  end
end