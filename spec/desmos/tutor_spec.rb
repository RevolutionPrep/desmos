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
    tutor.type.should eql('tutor')
    tutor.name.should eql('Test')
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