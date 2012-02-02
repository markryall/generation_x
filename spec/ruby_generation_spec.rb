require_relative 'spec_helper'

describe 'ruby code generation' do
  it 'should create a ruby class' do
    ex 'RubyClass class_a'
    vi 'ZZ'
    vi 'ZZ'
    read_file("#{BASE}/tmp/session/spec/class_a_spec.rb").should == <<-EOF
describe ClassA do
    
end
    EOF
    read_file("#{BASE}/tmp/session/lib/class_a.rb").should == <<-EOF
class ClassA
    
end
    EOF
  end
end
