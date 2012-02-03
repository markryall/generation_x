require_relative 'spec_helper'

describe 'ruby code generation' do
  it 'should create a ruby class' do
    ex 'RubyClass class_a'
    vi 'ZZ'
    vi 'ZZ'
    file("spec/class_a_spec.rb").should == <<-EOF
describe ClassA do
    
end
    EOF
    file("lib/class_a.rb").should == <<-EOF
class ClassA
    
end
    EOF
  end

  it 'should create a ruby module' do
    ex 'RubyModule module_a'
    vi 'ZZ'
    vi 'ZZ'
    file("spec/module_a_spec.rb").should == <<-EOF
describe ModuleA do
    
end
    EOF
    file("lib/module_a.rb").should == <<-EOF
module ModuleA
    
end
    EOF
  end

  it 'should not modify an existing file' do
    pending
    file 'lib/class_a.rb', '# a comment'
    ex 'RubyClass class_a'
    vi 'ZZ'
    vi 'ZZ'
    file('lib/class_a.rb').should == '# a comment'
  end

  it 'should not modify an existing buffer' do
    ex 'RubyClass class_a'
    ex 'RubyClass class_a'
    vi 'ZZ'
    vi 'ZZ'
    file("lib/class_a.rb").should == <<-EOF
class ClassA
    
end
    EOF
  end
end
