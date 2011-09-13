require 'spec_helper'

describe Desmos::Whiteboard, '.new' do

  it 'sets the instance variables based upon the options passed into the initializer' do
    tutor      = Desmos::Tutor.new(:id => 1, :name => 'test')
    students   = [Desmos::Student.new(:id => 2, :name => 'student')]
    whiteboard = Desmos::Whiteboard.new(
      :hash     => 'abcde',
      :title    => 'Title',
      :tutor    => tutor,
      :students => students
    )
    whiteboard.hash.should eql('abcde')
    whiteboard.title.should eql('Title')
    whiteboard.tutor.should eql(tutor)
    whiteboard.students.should eql(students)
  end

  it 'requires that the tutor option be either of type Desmos::Tutor or NilClass' do
    lambda {
      Desmos::Whiteboard.new(:tutor => 'tutor')
    }.should raise_error(ArgumentError, ':tutor option must be either of type Desmos::Tutor or NilClass')
  end

  it 'requires that the students option be either an Array containing object of type Desmos::Student or NilClass' do
    lambda {
      Desmos::Whiteboard.new(:students => ['student'])
    }.should raise_error(ArgumentError, ':students option must be either an Array containing object of type Desmos::Student or NilClass')

    lambda {
      Desmos::Whiteboard.new(:students => 'student')
    }.should raise_error(ArgumentError, ':students option must be either an Array containing object of type Desmos::Student or NilClass')

    lambda {
      Desmos::Whiteboard.new(:students => 2)
    }.should raise_error(ArgumentError, ':students option must be either an Array containing object of type Desmos::Student or NilClass')

    lambda {
      Desmos::Whiteboard.new(:students => [Desmos::Student.new(:id => 2, :name => 'student')])
    }.should_not raise_error

    lambda {
      Desmos::Whiteboard.new(:students => nil)
    }.should_not raise_error
  end

end

describe Desmos::Whiteboard, '#save' do

  context 'when the whiteboard does not already exist' do

    before(:each) do
      stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/create/).
        to_return(:status => 200, :body => "{\"success\": \"true\", \"hash\": \"abcde\"}")
    
      stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/set_tutor/).
        to_return(:status => 200, :body => "{\"success\": \"true\", \"hash\": \"abcde\"}")
      
      stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/add_student/).
        to_return(:status => 200, :body => "{\"success\": \"true\", \"hash\": \"abcde\"}")
    end

    it 'calls out to the Desmos API to save the whiteboard, tutor, and students' do
      tutor      = Desmos::Tutor.new(:id => 1, :name => 'tutor')
      student    = Desmos::Student.new(:id => 2, :name => 'student')
      whiteboard = Desmos::Whiteboard.new(:tutor => tutor)
      whiteboard.students << student
      whiteboard.save
    
      assert_requested :get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/create/, :times => 1
      assert_requested :get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/set_tutor/, :times => 1
      assert_requested :get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/add_student/, :times => 1
    end

  end

  context 'when the whiteboard already exists' do

    before(:each) do
      stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/create/).
        to_return(:status => 200, :body => "{\"success\": \"true\", \"hash\": \"abcde\"}").
        to_return(:status => 200, :body => "{\"success\":\"false\",\"error_code\":1,\"error_message\":\"whiteboard already exists\"}")
    end

    it 'calls out to the Desmos API to save the whiteboard, tutor, and students' do
      whiteboard = Desmos::Whiteboard.new
      whiteboard.save
      whiteboard.save
    
      assert_requested :get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/create/, :times => 2
    end

  end

end

describe Desmos::Whiteboard, '#request_options' do

  it 'builds a hash of options used to make requests from the Desmos API' do
    whiteboard = Desmos::Whiteboard.new
    whiteboard.request_options.should eql({})

    whiteboard = Desmos::Whiteboard.new(
      :hash  => 'abcde',
      :title => 'Title'
    )
    whiteboard.request_options.should eql({
      :hash  => 'abcde',
      :title => 'Title'
    })

    whiteboard = Desmos::Whiteboard.new(
      :hash  => 'abcde',
      :title => 'Title',
      :tutor => Desmos::Tutor.new(
        :id   => 1,
        :hash => 'zyxwv',
        :name => 'Mr. Tutor'
      )
    )
    whiteboard.request_options.should eql({
      :hash       => 'abcde',
      :title      => 'Title',
      :tutor_id   => 1,
      :tutor_hash => 'zyxwv',
      :tutor_name => 'Mr. Tutor'
    })
  end

end

describe Desmos::Whiteboard, '.create' do

  before(:each) do
    stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/create/).
      to_return(:status => 200, :body => "{\"success\": \"true\", \"hash\": \"abcde\"}")
    end

  it 'returns a new instance of DesmosWhiteboard' do
    whiteboard = Desmos::Whiteboard.create
    whiteboard.should be_kind_of(Desmos::Whiteboard)
    whiteboard.hash.should eql('abcde')
    assert_requested :get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/create/, :times => 1
  end

end

describe Desmos::Whiteboard, '.find' do

  context 'when the Whiteboard exists on the Desmos API' do

    before(:each) do
      stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/read/).
        to_return(:status => 200, :body => "{\"title\": \"No Title\", \"hash\": \"abcde\", \"tutor\": {\"id\": null, \"name\": null, \"hash\": null}, \"students\": []}")
    end

    it 'requests a Whiteboard from the Desmos API using its unique hash value' do
      whiteboard = Desmos::Whiteboard.find('abcde')
      whiteboard.should be_instance_of(Desmos::Whiteboard)
      whiteboard.hash.should eql('abcde')
      
      assert_requested :get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/read/, :times => 1
    end

  end

  context 'when the Whiteboard does not exist of the Desmos API' do

    before(:each) do
      stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/read/).
        to_return(:status => 200, :body => "{\"error_code\": 1, \"error_message\": \"Whiteboard not found\", \"success\": \"false\"}")
    end

    it 'raises an error if the Whiteboard' do
      lambda { Desmos::Whiteboard.find('abcde') }.should raise_error(Desmos::WhiteboardNotFound, 'Whiteboard with HASH=abcde could not be found')
    end

  end

end

describe Desmos::Whiteboard, '#build_from_hash' do

  it 'builds a fresh instance using the provided hash' do
    whiteboard = Desmos::Whiteboard.new.build_from_hash({
      :title => 'No Title',
      :hash  => 'abcde',
      :tutor => {
        :id   => 1,
        :hash => 'zyxwv',
        :name => 'test'
      },
      :students => []
    })
    whiteboard.should be_instance_of(Desmos::Whiteboard)
    whiteboard.title.should eql('No Title')
    whiteboard.hash.should eql('abcde')
    whiteboard.tutor.should be_instance_of(Desmos::Tutor)
    whiteboard.students.should be_empty
  end

end