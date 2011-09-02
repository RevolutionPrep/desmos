require 'spec_helper'

describe Desmos::RequestSupport, '#request!' do

  before(:each) do
    class_instance = Class.new
    class_instance.send(:include, Desmos::RequestSupport)
    @instance = class_instance.new
    
    stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/create/).
      to_return(:status => 200, :body => "{\"success\": \"true\", \"title\": \"Test Session\", \"hash\": \"abcde\"}")
  end

  it 'makes a request to the Desmos API with the given object, method, and options and returns a response parsed from JSON' do
    response = @instance.request!(:whiteboard, :create, { :title => 'Test Session' })
    response.should eql({
      :success => 'true',
      :hash    => 'abcde',
      :title   => 'Test Session'
    })
    assert_requested :get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/create/, :times => 1
  end

end

describe Desmos::RequestSupport, '#make_request' do
  
  before(:each) do
    class_instance = Class.new
    class_instance.send(:include, Desmos::RequestSupport)
    @instance = class_instance.new
    
    stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/create/)
  end

  it 'makes a request to the Desmos API with the given object, method, and options and returns a response from Net::HTTP' do
    response = @instance.make_request(:whiteboard, :create, { :title => 'Test Session' })
    response.should be_instance_of(Net::HTTPOK)
    assert_requested :get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/create/, :times => 1
  end
  
end

describe Desmos::RequestSupport, '#build_uri' do
  
  before(:each) do
    class_instance = Class.new
    class_instance.send(:include, Desmos::RequestSupport)
    @instance = class_instance.new
  end

  it 'builds a uri for the Desmos API from the given object, method, and options and returns the URI object' do
    uri = @instance.build_uri(:whiteboard, :create, { :title => 'Test Session' })
    uri.should be_instance_of(URI::HTTPS)
    uri.path.should eql('/api_v1/whiteboard/create')
    uri.query.should eql('title=Test+Session')
    uri.host.should eql(Desmos::Configuration.domain.split('://')[1])
  end
  
end

describe Desmos::RequestSupport, '#build_http' do
  
  before(:each) do
    class_instance = Class.new
    class_instance.send(:include, Desmos::RequestSupport)
    @instance = class_instance.new
  end
  
  it 'builds and returns a Net::HTTP instance setup for SSL' do
    http = @instance.build_http(@instance.build_uri(:whiteboard, :create, { :title => 'Test Session' }))
    http.should be_instance_of(Net::HTTP)
  end
  
end

describe Desmos::RequestSupport, '#parse_response' do
  
  before(:each) do
    class_instance = Class.new
    class_instance.send(:include, Desmos::RequestSupport)
    @instance = class_instance.new
    
    stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/create/).
      to_return(:status => 200, :body => "{\"success\": \"true\", \"title\": \"Test Session\", \"hash\": \"abcde\"}")
  end
  
  it 'parses the JSON response string into a Hash' do
    response = @instance.make_request(:whiteboard, :create, { :title => 'Test Session', :hash => 'abcde' })
    parsed_response = @instance.parse_response(response)
    parsed_response.should be_instance_of(Hash)
    parsed_response.should eql({
      :success => 'true',
      :title   => 'Test Session',
      :hash    => 'abcde'
    })
  end
  
end