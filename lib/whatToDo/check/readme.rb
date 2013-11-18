check do
  re = nil
  found = false

  ['README', 'README.md', 'README.txt', 'README.html'].each do |fileName|
    if File.file?(fileName)
      found = true
      break
    end
  end

  unless found
    re = "There is no readme file in that project. Create one!".bold.white
  end

  re
end
