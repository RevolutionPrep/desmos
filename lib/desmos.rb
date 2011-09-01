require 'oauth'
require 'yajl'

module Desmos
  API_DOMAIN     = 'https://revolutionprep.tutortrove.com'
  API_VERSION = 'api_v1'

  # WHITEBOARD_OPTIONS
  # {
  #   :whiteboard_hash  => 'Another Session'.hash,
  #   :whiteboard_title => 'Study Session',
  #   :user_type        => 'tutor',
  #   :user_id          => '451',
  #   :user_name        => 'Briana Agatep'
  # }
  def self.link_from_hash(whiteboard_options)
    query_string = Typhoeus::Utils.traversal_to_param_string(Typhoeus::Utils.traverse_params_hash(whiteboard_options))
    url          = URI.parse("#{API_URL}/v1/SSO/whiteboard?#{query_string}")
    consumer     = OAuth::Consumer.new('133', "b425c6e1c0deb6a49bd9c6ae282ac146", :site => API_URL)
    request      = consumer.create_signed_request(:get, "#{url.path}?#{url.query}", nil, whiteboard_options.merge(:scheme => 'query_string'))
    "#{API_URL + request.path}"
  end

  class Whiteboard
    attr_reader :hash, :title, :tutor_name, :tutor_id, :tutor_hash

    def self.create(options = {})
      new(options).save
    end

    def initialize(options = {})
      @hash       = options[:hash]       # optional: The API will generate this if not provided. Must be unique if provided.
      @title      = options[:title]      # optional
      @tutor_name = options[:tutor_name] # optional
      @tutor_id   = options[:tutor_id]   # optional: If you want to include a tutor, this must be included.
      @tutor_hash = options[:tutor_hash] # optional: If you include a tutor_id but not a hash, the API will generate one and return it.
    end

    def save
      build_request!
      build_http!
      request!
      parse_response!
      @parsed_response.fetch(:hash)
    end

    def build_request!
      @query_string = Typhoeus::Utils.traversal_to_param_string(Typhoeus::Utils.traverse_params_hash(request_options))
      @uri          = URI.parse("#{API_DOMAIN}/#{API_VERSION}/whiteboard/create?#{@query_string}")
      @consumer     = OAuth::Consumer.new('133', "b425c6e1c0deb6a49bd9c6ae282ac146", :site => API_DOMAIN)
      @request      = @consumer.create_signed_request(:get, "#{API_DOMAIN}#{@uri.path}?#{@uri.query}", nil, request_options.merge(:scheme => 'query_string'))
    end

    def build_http!
      @http             = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl     = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    def request!
      @response = @http.request(@request)
    end

    def parse_response!
      @parsed_response = Yajl::Parser.parse(@response.body).symbolize_keys
      raise RequestError, "Request was not successful: #{@parsed_response.inspect}" unless !!@parsed_response[:success]
    end

    def request_options
      @request_options ||= begin
        options = {}
        options.merge!(:hash       => hash)       if hash
        options.merge!(:title      => title)      if title
        options.merge!(:tutor_name => tutor_name) if tutor_name
        options.merge!(:tutor_id   => tutor_id)   if tutor_id
        options.merge!(:tutor_hash => tutor_hash) if tutor_hash
        options
      end
    end

  end

  class RequestError < StandardError
  end
end