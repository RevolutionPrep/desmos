require 'spec_helper'

describe Desmos::Tutor, '.new' do
  
  it 'sets the instance variables for the tutor' do
    tutor = Desmos::Tutor.new(
      :id   => 1,
      :hash => 'abcde',
      :name => 'Test Tutor'
    )
    tutor.id.should eql(1)
    tutor.hash.should eql('abcde')
    tutor.name.should eql('Test Tutor')
  end
  
end
