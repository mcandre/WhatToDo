require 'rubygems'
require 'optparse'
require 'colored'
require 'wife/util'
require 'wife/check_manager'
require 'wife/facet_analyzer'


# Command line options
options = {
	debug: true,
}

opt_parser = OptionParser.new do |opt|
  opt.banner = 'Usage: wife [OPTIONS]'
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
facet_analyzer = Wife::FacetAnalyzer.new
facets = facet_analyzer.facets


# Init the check manager and run all checks
check_manager = Wife::CheckManager.new(facets)
check_results = check_manager.run_checks(10)


# Show the facets
puts
puts 'Project facets: '.bold.white
puts '  ' + facets.map{ |f| f.to_s }.join(', ')
puts


# If it's a git project, display the last commit messages and the last changed files
if facets.include?(:git)
  puts 'Last commits:'.bold.white
  puts indent(`git log -5 --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative`, 2)
  puts

  puts 'Last changed files:'.bold.white
  puts indent(`git diff $(git log -5 --format=%H | tail -n1).. --stat`, 1)
  puts
end


# Print the result
if check_results.length > 0
  puts 'Suggested todo:'.bold.white
  puts '  ' + check_results.sample
else
  puts 'Nothing to do here!'.green
end
