require 'spec_helper'

describe Desmos::Student, '.new' do

  it 'sets the instance variables for the student' do
    student = Desmos::Student.new(
      :id          => 1,
      :hash        => 'abcde',
      :name        => 'Test',
      :last_name   => 'Student',
      :family_name => 'StudentName',
      :skype       => 'test_student',
      :email       => 'test_student@example.com'
    )
    student.id.should eql(1)
    student.hash.should eql('abcde')
    student.type.should eql('student')
    student.name.should eql('Test')
    student.last_name.should eql('Student')
    student.family_name.should eql('StudentName')
    student.skype.should eql('test_student')
    student.email.should eql('test_student@example.com')
  end

  it 'requires a name attribute' do
    lambda { Desmos::Student.new(:id => 1) }.should raise_error(ArgumentError, ':name is a required attribute')
  end

  it 'requires an id attribute' do
    lambda { Desmos::Student.new(:name => 'test') }.should raise_error(ArgumentError, ':id is a required attribute')
  end

end

describe Desmos::Student, '.build_from_hash' do

  it 'returns a Desmos::Student object' do
    student = Desmos::Student.build_from_hash(:id => 1, :name => 'test')
    student.should be_instance_of(Desmos::Student)
  end

end