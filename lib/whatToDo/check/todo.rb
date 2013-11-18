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

  result = "\n\n"

  snippet(file, from, line + 4).split("\n").each do |code_line|
    active = (line == from)
    spaces = " " * (8 - from.to_s.length - (active ? 3 : 0))
    result << spaces + (active ? '>> '.bold.red : '')
    result << from.to_s.bold.yellow + ": ".bold.yellow

    first = true

    if code_line.length > 0
      scan = code_line.scan(/^ +/)[0]
      ident = scan ? scan.length + 12 : 12
      code_line.scan(/.{1,80}/m).each do |l|
        result << (first ? '' : ' ' * ident) + (active ? l.bold.red : l) + "\n"
        first = false
      end
    else
      result << "\n"
    end

    from += 1
  end

  result
end



##
## Extracs a code snippet from a file and reduced the identation to the minimum
##

def snippet(file, from, to)
  code = ""
  current_line = 0

  File.open(file, 'r') do |f|
    while read_line = f.gets
      current_line += 1
      code << read_line.gsub(/\t/m, '  ') if current_line >= from && current_line <= to
    end
  end

  code.gsub(/^#{code.scan(/^\s+/).min}/, '')
end



##
## Reduces the identation of a given string to the minimum
##

def unindent(code)
  code.gsub(/^#{scan(/^\s+/).min}/, "")
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
