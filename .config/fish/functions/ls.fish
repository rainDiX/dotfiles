function ls --description 'List contents of directory'
	exa $argv
end

function ll --description 'List contents of directory using long format'
	exa -lgh $argv
end

function la --description 'List contents of directory, including hidden files in directory using long format'
	exa -lah $argv
end

function tree --description 'Lists directories recursively, and produces an indented listing of files'
	exa -T $argv
end
