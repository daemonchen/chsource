require 'chsource'
require 'chsource/version'
require 'optparse'

module Chsource
  module CLI
    def self.invalid_input?
      ARGV.size > 1 || !Chsource::Source.keys.include?(ARGV[0].to_sym)
    end
    def self.start(args)
      ARGV << '-h' if ARGV.empty? && $stdin.tty? || invalid_input?

      opts = OptionParser.new do |opts|
        opts.banner = "Usage: chsource SOURCE" 

        opts.separator " "

        opts.separator "Examples:"
        opts.separator "  $ chsource taobao   => source 'http://ruby.taobao.org'"
        opts.separator "  $ chsource gzruby   => source 'http://gems.gzruby.com"
        opts.separator "  $ chsource tsinghua => source 'http://mirrors.tuna.tsinghua.edu.cn/rubygems'"
        opts.separator "  $ chsource rubygems => source 'http://rubygems.org'"

        opts.separator " "
        opts.separator "Options:"

        opts.on("-v", "--version", "Print the version") do |v|
          puts "Chsource v#{VERSION}"
          exit
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        opts.parse!(args)
      end

      Chsource.change_source ARGV[0]
    end
  end
end
