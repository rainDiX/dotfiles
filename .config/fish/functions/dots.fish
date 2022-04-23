function dots --description 'Manage the dotfiles git bare repository'
    git --git-dir=$HOME/.local/share/dots --work-tree=$HOME $argv
end
