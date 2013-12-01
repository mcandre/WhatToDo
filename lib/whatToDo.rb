require 'rubygems'
require 'optparse'
require 'colored'
require 'whatToDo/check_manager'
require 'whatToDo/facet_analyzer'


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


# Init the facet analyser and run it so we know what project we have here.
facet_analyzer = WhatToDo::FacetAnalyzer.new
facets = facet_analyzer.facets


# Init the check manager and run all checks
check_manager = WhatToDo::CheckManager.new(facets)
check_results = check_manager.run_checks(10)


# Show the facets
puts
puts "Project facets: " + facets.map{ |f| f.to_s }.join(', ')
puts


# Print the result
if check_results.length > 0
  puts check_results.sample
else
  puts "Nothing to do here!".green
end
