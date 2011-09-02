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