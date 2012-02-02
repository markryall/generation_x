require 'fileutils'

BASE = File.expand_path File.dirname(__FILE__)+'/..'

module Tmux
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

  def read_file path
    10.times do
      return File.read(path) if File.exist? path
      sleep 0.25
    end
  end
end

RSpec.configure do |c|
  c.include Tmux

  c.around(:each) do |example|
    here = File.expand_path File.dirname(__FILE__)+'/..'
    rm_rf "#{BASE}/tmp/session"
    mkdir_p "#{BASE}/tmp/session"
    send_keys 'C-c'
    command "cd #{BASE}/tmp/session"
    command 'vim'
    example.run
    send_keys 'Escape'
    send_keys 'ZZ'
  end
end
