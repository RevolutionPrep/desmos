require 'spec_helper'

describe Desmos::Configuration, '.domain' do

  it 'has a domain attribute, that when set will return the domain' do
    Desmos::Configuration.should respond_to(:domain)
    Desmos::Configuration.domain = 'https://example.com'
    Desmos::Configuration.domain.should eql('https://example.com')
  end

  it 'raises a ConfigurationError if domain is called without having been set' do
    Desmos::Configuration.domain = nil
    lambda { Desmos::Configuration.domain }.should raise_error(Desmos::ConfigurationError, 'Desmos::Configuration.domain is a required configuration value.')
  end

  it 'adds https:// scheme if none is provided' do
    Desmos::Configuration.domain = 'something.com'
    Desmos::Configuration.domain.should eql('https://something.com')
  end

  it 'converts a regular http:// scheme to https:// if needed' do
    Desmos::Configuration.domain = 'http://something.com'
    Desmos::Configuration.domain.should eql('https://something.com')
  end

end

describe Desmos::Configuration, '.version' do

  it 'has a version attribute, that when set will return the version' do
    Desmos::Configuration.should respond_to(:version)
    Desmos::Configuration.version = 'api_v1'
    Desmos::Configuration.version.should eql('api_v1')
  end

  it 'raises a ConfigurationError if version is called without having been set' do
    Desmos::Configuration.version = nil
    lambda { Desmos::Configuration.version }.should raise_error(Desmos::ConfigurationError, 'Desmos::Configuration.version is a required configuration value.')
  end

  it "prepends the version with 'api_v' if that part of the string does not exist" do
    Desmos::Configuration.version = 1
    Desmos::Configuration.version.should eql('api_v1')
  end

  it "prepends the version with 'api_v' if that part of the string does not exist" do
    Desmos::Configuration.version = '1'
    Desmos::Configuration.version.should eql('api_v1')
  end

  it "parses out a number if there is one to use as the version" do
    Desmos::Configuration.version = 'this really 4 should not work'
    Desmos::Configuration.version.should eql('api_v4')
  end

end

describe Desmos::Configuration, '.key' do

  it 'has a key attributes, that when set will return the key' do
    Desmos::Configuration.should respond_to(:key)
    Desmos::Configuration.key = '133'
    Desmos::Configuration.key.should eql('133')
  end

  it 'raises a ConfigurationError if key is called without having been set' do
    Desmos::Configuration.key = nil
    lambda { Desmos::Configuration.key }.should raise_error(Desmos::ConfigurationError, 'Desmos::Configuration.key is a required configuration value.')
  end

  it 'converts whatever is passed in into a String' do
    Desmos::Configuration.key = 133
    Desmos::Configuration.key.should eql('133')

    Desmos::Configuration.key = true
    Desmos::Configuration.key.should eql('true')
  end

end

describe Desmos::Configuration, '.secret' do

  it 'has a secret attribute, that when set will return the secret' do
    Desmos::Configuration.should respond_to(:secret)
    Desmos::Configuration.secret = 'abcde'
    Desmos::Configuration.secret.should eql('abcde')
  end

  it 'raises a ConfigurationError is secret is called without having been set' do
    Desmos::Configuration.secret = nil
    lambda { Desmos::Configuration.secret }.should raise_error(Desmos::ConfigurationError, 'Desmos::Configuration.secret is a required configuration value.')
  end

end