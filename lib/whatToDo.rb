require 'rubygems'
require 'optparse'


# Command line options
options = {
	debug: true,
}

opt_parser = OptionParser.new do |opt|
  opt.banner = 'Usage: whatToDo [OPTIONS]'
  opt.separator ''
  opt.separator 'Options'

  opt.on('-d', '--debug', 'Enable stacktrace output.') do
    options[:debug] = true
  end

  opt.on('-h', '--help', 'help') do
    puts opt_parser
  end
end

opt_parser.parse!


# Require all check scripts
Dir["lib/check/*.rb"].each { |file| require file }
