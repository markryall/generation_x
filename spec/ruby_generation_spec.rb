require 'fileutils'

describe 'ruby code generation' do
  BASE = File.expand_path File.dirname(__FILE__)+'/..'
  include FileUtils

  def send_keys keys
    system "tmux send-keys -t0 \"#{keys}\""
  end

  def command cmd
    send_keys cmd
    send_keys "Enter"
  end

  def ex cmd
    send_keys ":#{cmd}"
    send_keys "Enter"
  end

  def vi command
    send_keys command
    send_keys 'Escape'
  end

  before do
    here = File.expand_path File.dirname(__FILE__)+'/..'
    rm_rf "#{BASE}/tmp/session"
    mkdir_p "#{BASE}/tmp/session"
    send_keys 'C-c'
    command "cd #{BASE}/tmp/session"
    command 'vim'
  end

  after do
    send_keys 'Escape'
    send_keys 'ZZ'
  end

  def read_file path
    10.times do
      return File.read(path) if File.exist? path
      sleep 0.25
    end
  end

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
