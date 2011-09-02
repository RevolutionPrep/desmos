module Desmos
  module RequestSupport

    def make_request(object, method, options = {})
      uri      = build_uri(object, method, options)
      consumer = OAuth::Consumer.new(Configuration.key, Configuration.secret, :site => Configuration.domain)
      http     = build_http(uri)
      request  = consumer.create_signed_request(:get, "#{Configuration.domain}#{uri.path}?#{uri.query}", nil, options.merge(:scheme => 'query_string'))
      http.request(request)
    end

    def build_uri(object, method, options = {})
      query_string = Desmos::Utils.traversal_to_param_string(Desmos::Utils.traverse_params_hash(options))
      URI.parse("#{Configuration.domain}/#{Configuration.version}/#{object}/#{method}?#{query_string}")
    end

    def build_http(uri)
      http             = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl     = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

    def request!(object, method, options = {})
      response = make_request(object, method, options)
      parse_response(response)
    end

    def parse_response(response)
      parsed_response = Yajl::Parser.parse(response.body).symbolize_keys
    end

  end
end