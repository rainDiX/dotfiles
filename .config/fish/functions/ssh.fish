function ssh --description 'set universal TERM var for ssh'
    env TERM=xterm-256color ssh $argv
end
