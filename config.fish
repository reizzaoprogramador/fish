# @file: $OFISH/config.fish
# @mission: Inicialização, padronização e carregamento de ambiente do Fish

if status is-interactive
    set -g fish_greeting
end

# 1. DIRS_NIVEL 1
set -gx CONFIG_HOME "$HOME/.config"
set -gx WWW "$HOME/www"
set -gx DOTFILES "$WWW/dotfiles"

# 2. INCLUDED PROGRAMS
set -gx PROGRAMS "$CONFIG_HOME"
set -gx OSHELLBASH "$PROGRAMS/shellbash"
set -gx OVIM "$PROGRAMS/vim"
set -gx ONVIM "$PROGRAMS/nvim"
set -gx OTMUX "$PROGRAMS/tmux"
set -gx OSTARSHIP "$PROGRAMS/starship"
set -gx OSF "$PROGRAMS/superfile"
set -gx OFISH "$PROGRAMS/fish"
set -gx OYAZI "$PROGRAMS/yazi"
set -gx OI3 "$PROGRAMS/i3"

# 3. SHELLBASH E VARS
set -gx ENVS "$OSHELLBASH/env"
set -gx ALIASES "$OSHELLBASH/aliases"
set -gx FUNC_SH "$OSHELLBASH/functions"
set -gx FUNC "$OFISH/functions"

# 4. Array para automação via gitall
set -gx ARRAY_BY_GITALL "$OSHELLBASH" "$PROGRAMS" "$WWW" "$OVIM" "$ONVIM" "$OTMUX" "$OSTARSHIP" "$OFISH" "$OYAZI" "$OI3"

# Sobrescreve vars do sistema
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

if test -z "$ROOT_SHELL"
    set -gx ROOT_SHELL "/usr/bin/fish"
end

# Modo VIM no Shell
fish_vi_key_bindings
bind -M insert -m default jj force-repaint
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_visual underscore

# == IMPORTS ==
if test -f "$ENVS/.env_rz"
    for line in (cat "$ENVS/.env_rz" | grep -v '^#' | grep -v '^$')
        set -l clean_line (string replace -r '^export\s+' '' $line)
        set -l item (string split -m 1 '=' $clean_line)
        if test (count $item) -eq 2
            set -gx $item[1] (string trim -c '"\'' $item[2])
        end
    end
end

if test -f "$ALIASES/aliases.fish"
    source "$ALIASES/aliases.fish"
end

# Carrega bootstrap do Fish (ele mesmo define suas variáveis e dependências internamente)
if test -f "$HOME/www/bootstrap/main.fish"
    source "$HOME/www/bootstrap/main.fish"
end

# ==============================================================================
# @README
# @objetivo_file: inicializar variaveis e funcoes do sistema no Fish
# @tags: #www #wAPP_SYS_PC_01 #vibecode #fish
# ==============================================================================