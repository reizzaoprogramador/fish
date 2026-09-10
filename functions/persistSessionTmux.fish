#!/bin/fish
# @file: ~/.config/fish/functions/persistSessionTmux.fish
# @mission: gerencia persistencia inteligente do tmux usando caminho customizado

function persistSessionTmux
    # @desc: Salva ou restaura sessoes ativas do tmux usando variavel de caminho
    # @mission: Permitir customizacao do local de armazenamento do estado

    # Usa a variavel LISTEN_TMUX se definida, caso contrario define o padrao
    set -q LISTEN_TMUX; or set -g LISTEN_TMUX "$HOME/.tmux_last_state"
    set SESSION_NAME "mainWork"

    if test "$argv[1]" = "save"
        if tmux has-session -t $SESSION_NAME 2>/dev/null
            tmux list-windows -t $SESSION_NAME -F "#{window_name}:#{pane_current_path}" > $LISTEN_TMUX
        end
        return 0
    end

    if tmux has-session -t $SESSION_NAME 2>/dev/null
        if test -z "$TMUX"
            tmux attach-session -t $SESSION_NAME
        end
        return 0
    end

    if test -f $LISTEN_TMUX; and test -s $LISTEN_TMUX
        set -l first_line (head -n 1 $LISTEN_TMUX)
        set -l win_name (string split -m 1 ":" $first_line)[1]
        set -l win_path (string split -m 1 ":" $first_line)[2]

        tmux new-session -d -s $SESSION_NAME -n "$win_name" -c "$win_path"

        tail -n +2 $LISTEN_TMUX | while read -l line
            set -l name (string split -m 1 ":" $line)[1]
            set -l path (string split -m 1 ":" $line)[2]
            if test -n "$name"
                tmux new-window -t $SESSION_NAME -n "$name" -c "$path"
            end
        end
    else
        tmux new-session -d -s $SESSION_NAME -n "editor" -c "$HOME"
        tmux split-window -h -t "$SESSION_NAME:editor"
    end

    if test -z "$TMUX"
        tmux attach-session -t $SESSION_NAME
    end

# =============================================================
# @How_To_Use
# persistSessionTmux
# persistSessionTmux save

# ===========================================================
end