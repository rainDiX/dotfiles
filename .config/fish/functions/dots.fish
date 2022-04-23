function dots --description 'Manage the dotfiles git bare repository'
    git --git-dir=$HOME/.local/dots --work-tree=$HOME $argv
end
