set fish_greeting

set fish_prompt_pwd_dir_length 0

function fish_prompt
    set -l __last_command_exit_status $status

    set -l __status_state ""

    if test $__last_command_exit_status != 0
        set __status_state (printf "%s%s " (set_color red) $__last_command_exit_status)
    end

    set -l git (gitprompt)

    if test $git
        printf "%s%s%s %s» %s" (set_color blue) (prompt_pwd) $git $__status_state (set_color normal)
    else
        printf "%s%s %s%s» %s" (set_color blue) (prompt_pwd) (set_color normal) $__status_state (set_color normal)
    end
end

alias vim="nvim"
alias vi="nvim"
alias v="nvim"
rvm default
