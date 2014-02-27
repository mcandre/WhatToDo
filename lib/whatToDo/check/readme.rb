check do
  re = nil
  found = false

  ['README.rdoc', 'README', 'README.md', 'README.txt', 'README.html'].each do |fileName|
    if File.file?(fileName)
      found = true
      break
    end
  end

  unless found
    re = "There is no readme file in that project. Create one!"
  end

  re
end
