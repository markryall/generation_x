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

  def buffer
    system "tmux capture-pane -t0"
    `tmux show-buffer`
  end

  def base *args
    File.join [BASE,'tmp','session']+args
  end

  def file path, content=nil
    if content
      mkdir_p File.dirname(path)
      File.open('path', 'w') {|file| puts content}
    else
      path = base path
      10.times do
        return File.read(path) if File.exist? path
        sleep 0.25
      end
    end
    content
  end
end

RSpec.configure do |c|
  c.include Tmux

  c.around(:each) do |example|
    rm_rf base
    mkdir_p base
    send_keys 'C-c'
    command "cd #{base}"
    command 'vim'
    example.run
    send_keys 'Escape'
    send_keys 'ZZ'
  end
end
