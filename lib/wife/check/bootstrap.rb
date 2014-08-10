check do
  if File.file?('script/bootstrap') || File.file?('script/setup')
    nil
  else
    "There is no 'script/bootstrap' or 'script/setup' file in that project. Create one!"
  end
end
