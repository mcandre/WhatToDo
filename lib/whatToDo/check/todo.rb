def get_lines
  exclude = ''

  if File.file?(".gitignore")
    exclude = `cat .gitignore`.split("\n").map { |l| " | grep -v '^#{l}'" }
    exclude = exclude.join
  end

  `egrep -rnH 'TODO|FIXME|XXX' * | grep -v '^Binary file' #{exclude}`.split("\n")
end


check do
  todos = get_lines.map do |line|
    splitted = line.split(':', 3)
    todo = splitted[2].strip.tr('//', '').tr('*', '').tr('<!--', '').tr('-->', '').strip
    "Found a ToDo in #{splitted[0]} at line #{splitted[1]}:\n #{todo}"
  end

  todos.sample
end