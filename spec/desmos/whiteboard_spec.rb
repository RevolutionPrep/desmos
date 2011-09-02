require 'spec_helper'

describe Desmos::Whiteboard, '.new' do

  it 'sets the instance variables based upon the options passed into the initializer' do
    tutor      = Desmos::Tutor.new
    students   = [Desmos::Student.new]
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
      Desmos::Whiteboard.new(:students => [Desmos::Student.new])
    }.should_not raise_error

    lambda {
      Desmos::Whiteboard.new(:students => nil)
    }.should_not raise_error
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
  end

end

describe Desmos::Whiteboard, '#save' do

  before(:each) do
    stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/whiteboard\/create/).
      to_return(:status => 200, :body => "{\"success\": \"true\", \"hash\": \"abcde\"}")
  end

  it 'calls out to the Desmos API to save the whiteboard' do
    whiteboard = Desmos::Whiteboard.new
    whiteboard.save
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