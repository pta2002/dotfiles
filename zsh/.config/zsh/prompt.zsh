setopt PROMPT_SUBST

export PROMPT='%{$fg[blue]%}%~%{$reset_color%}$(gitprompt) %(?..%{$fg[red]%}%? )» '
