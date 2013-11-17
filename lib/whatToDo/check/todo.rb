##
## Executes a recursive grep in the current directory to find all todos,
## and the respecitve filename and linenumber. If there's a .gitignore
## that function will ignore all directories and files from .gitignore
##

def get_lines
  exclude = ''

  if File.file?(".gitignore")
    exclude = `cat .gitignore`.split("\n").map { |l| " | grep -v '^#{l}'" }
    exclude = exclude.join
  end

  `egrep -rnH 'TODO|FIXME|XXX' * | grep -v '^Binary file' #{exclude}`.split("\n")
end



##
## Builds a code sample from the given file and linenumber. Will display
## the 4 lines above and below the relevant line and will highlight the
## relevant line.
##

def code_sample(file, line)
  line = line.to_i

  from = line - 4
  from = 0 if from < 0

  to = line + 4

  current_line = 0
  result = "\n\n"

  File.open(file, 'r') do |f|
    while read_line = f.gets
      current_line += 1

      if current_line >= from && current_line <= to
        spaces = " " * (8 - current_line.to_s.length - (line == current_line ? 3 : 0))
        result << spaces + (line == current_line ? '>> ' : '') + current_line.to_s + ": " + read_line
      end
    end
  end

  result
end



##
## Register the check script
##
check do
  todos = get_lines.map do |line|
    splitted = line.split(':', 3)
    result = "Found a ToDo in #{splitted[0]} at line #{splitted[1]}:\n"
	result << code_sample(splitted[0], splitted[1])
    result
  end

  todos.sample
end
