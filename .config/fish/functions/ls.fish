function ls --description 'List contents of directory'
  if type -q exa
    exa $argv
  else
    /bin/ls $argv
  end
end

function ll --description 'List contents of directory using long format'
  if type -q exa
    exa -lgh $argv
  else
    /bin/ls -lgh $argv
  end
end

function la --description 'List contents of directory, including hidden files in directory using long format'
  if type -q exa
    exa -lah $argv
  else
    /bin/ls -lah $argv
  end
end

function lt --description 'Lists directories recursively, and produces an indented listing of files'
  exa -T $argv
end
