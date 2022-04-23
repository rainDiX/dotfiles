# Defined interactively
function fish_prompt --description 'pythonista extended'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)

    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end

    set -l color_cwd $fish_color_cwd
    set -l suffix '→'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # If we're running via SSH, change the host color.
    set -l color_host brblue
    if set -q SSH_TTY
        set color_host $fish_color_host_remote
    end

    # If we're running in a toolbox, append a hexagon symbol.
    set toolbox_symbol ''
    if test -f /run/.containerenv -a -f /run/.toolboxenv
        #set toolbox_symbol '⬢'
	set toolbox_symbol '🔧'
    end

    # Write pipestatus
    # If the status was carried over (e.g. after `set`), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" (set_color $fish_color_status) (set_color $bold_flag $fish_color_status) $last_pipestatus)

    # virtualenv
    if test -n "$VIRTUAL_ENV"
        printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
    end

    # first line
    printf '%s%s %sat %s%s%s %sin %s%s%s%s' (set_color $fish_color_user) $USER \
            $normal (set_color $color_host) $toolbox_symbol (prompt_hostname) $normal (set_color $fish_color_cwd)\
            (prompt_pwd) $normal (fish_vcs_prompt)
    # Background jobs
    for job in (jobs)
        printf '\n%s │ %s%s' (set_color brblack) $job $normal
    end
    # last line
    printf '\n%s%s%s ' $prompt_status $normal $suffix
end
