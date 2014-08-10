# Helper method to ident a string
def indent(str, count, char = ' ')
  str.gsub(/([^\n]*)(\n|$)/) do |match|
    last_iteration = ($1 == '' && $2 == '')
    line = ''
    line << (char * count) unless last_iteration
    line << $1
    line << $2
    line
  end
end