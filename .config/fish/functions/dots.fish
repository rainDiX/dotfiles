function dots --description 'Manage the dotfiles git bare repository'
	git --git-dir=$HOME/.cfg --work-tree=$HOME $argv
end
