require 'spec_helper'

describe Desmos::User, '.new' do

  it 'sets the instance variables for the tutor' do
    user = Desmos::User.new(
      :id          => 1,
      :hash        => 'abcde',
      :name        => 'Test',
      :last_name   => 'User',
      :family_name => 'UserName',
      :skype       => 'test_user',
      :email       => 'test_user@example.com'
    )
    user.id.should eql(1)
    user.hash.should eql('abcde')
    user.type.should eql('user')
    user.name.should eql('Test')
    user.last_name.should eql('User')
    user.family_name.should eql('UserName')
    user.skype.should eql('test_user')
    user.email.should eql('test_user@example.com')
  end

  it 'requires a name attribute' do
    lambda { Desmos::User.new(:id => 1) }.should raise_error(ArgumentError, ':name is a required attribute')
  end

  it 'requires an id attribute' do
    lambda { Desmos::User.new(:name => 'test') }.should raise_error(ArgumentError, ':id is a required attribute')
  end

end

describe Desmos::User, '.build_from_hash' do

  it 'returns a Desmos::User object' do
    user = Desmos::User.build_from_hash(:id => 1, :name => 'test')
    user.should be_instance_of(Desmos::User)
  end

end

describe Desmos::User, '#save' do

  before(:each) do
    stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/users\/create/).
      to_return(:status => 200, :body => "{\"success\": \"true\"}")
  end

  it 'calls out to the Desmos API to save the user' do
    user = Desmos::User.new(:id => 1, :name => 'test')
    user.save
  end

end

describe Desmos::User, '.create' do

  before(:each) do
    stub_request(:get, /https\:\/\/api\.tutortrove\.com\/api_v1\/users\/create/).
      to_return(:status => 200, :body => "{\"success\": \"true\"}")
  end

  it 'calls out to the Desmos API to save the user' do
    user = Desmos::User.create(:id => 1, :name => 'test')
    user.should be_instance_of(Desmos::User)
  end

end