module Desmos
  module RequestSupport
    include DebugMode

    def request!(object, method, options = {})
      debug "\n[RequestSupport.request!] (#{object.inspect}, #{method.inspect}, #{options.inspect})"
      response = make_request(object, method, options)
      parse_response(response)
    end

    def make_request(object, method, options = {})
      debug "\n[RequestSupport.make_request] (#{object.inspect}, #{method.inspect}, #{options.inspect})"
      uri      = build_uri(object, method, options)
      consumer = OAuth::Consumer.new(Configuration.key, Configuration.secret, :site => Configuration.domain)
      http     = build_http(uri)
      request  = consumer.create_signed_request(:get, "#{Configuration.domain}#{uri.path}?#{uri.query}", nil, options.merge(:scheme => 'query_string'))
      debug "request:\n#{request.path}"
      http.request(request)
    end

    def build_uri(object, method, options = {})
      debug "\n[RequestSupport.build_uri]: (#{object.inspect}, #{method.inspect}, #{options.inspect})"
      query_string = Desmos::Utils.traversal_to_param_string(Desmos::Utils.traverse_params_hash(options))
      uri = URI.parse("#{Configuration.domain}/#{Configuration.version}/#{object}/#{method}?#{query_string}")
      debug "uri = #{uri.to_s}"
      uri
    end

    def build_http(uri)
      debug "\n[RequestSupport.build_http] (#{uri.inspect})"
      http             = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl     = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

    def parse_response(response)
      debug "\n[RequestSupport.parse_response] (#{response.inspect})"
      debug "response.body:\n#{response.body}"
      parsed_response = Yajl::Parser.parse(response.body).recursive_symbolize_keys
    end

  end
end