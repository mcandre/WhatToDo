check do
  if File.file?('script/bootstrap')
    nil
  else
    "There is no script/bootstrap file in that project. Create one!"
  end
end
