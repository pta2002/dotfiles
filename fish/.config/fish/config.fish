set fish_greeting

set fish_prompt_pwd_dir_length 0

function fish_prompt
    set -l __last_command_exit_status $status

    printf "%s%s %s» " (set_color blue) (prompt_pwd) (set_color normal)
end
