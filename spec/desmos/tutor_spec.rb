require 'spec_helper'

describe Desmos::Tutor, '.new' do

  it 'sets the instance variables for the tutor' do
    tutor = Desmos::Tutor.new(
      :id          => 1,
      :hash        => 'abcde',
      :name        => 'Test',
      :last_name   => 'Tutor',
      :family_name => 'TutorName',
      :skype       => 'test_tutor',
      :email       => 'test_tutor@example.com'
    )
    tutor.id.should eql(1)
    tutor.hash.should eql('abcde')
    tutor.name.should eql('Test')
    tutor.last_name.should eql('Tutor')
    tutor.family_name.should eql('TutorName')
    tutor.skype.should eql('test_tutor')
    tutor.email.should eql('test_tutor@example.com')
  end

  it 'requires a name attribute' do
    lambda { Desmos::Tutor.new(:id => 1) }.should raise_error(ArgumentError, ':name is a required attribute')
  end

  it 'requires an id attribute' do
    lambda { Desmos::Tutor.new(:name => 'test') }.should raise_error(ArgumentError, ':id is a required attribute')
  end

end

describe Desmos::Tutor, '.build_from_hash' do

  it 'returns a Desmos::Tutor object' do
    tutor = Desmos::Tutor.build_from_hash(:id => 1, :name => 'test')
    tutor.should be_instance_of(Desmos::Tutor)
  end

end

describe Desmos::Tutor, '#save' do

  before(:each) do
    stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/users\/create/).
      to_return(:status => 200, :body => "{\"success\": \"true\"}")
  end

  it 'calls out to the Desmos API to save the tutor' do
    tutor = Desmos::Tutor.new(:id => 1, :name => 'test')
    tutor.save
  end

end

describe Desmos::Tutor, '.create' do

  before(:each) do
    stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/users\/create/).
      to_return(:status => 200, :body => "{\"success\": \"true\"}")
  end

  it 'calls out to the Desmos API to save the tutor' do
    tutor = Desmos::Tutor.create(:id => 1, :name => 'test')
    tutor.should be_instance_of(Desmos::Tutor)
  end

end