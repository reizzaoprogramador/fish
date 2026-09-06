# @file: $OFISH/config.fish
# @mission: Inicialização, padronização e carregamento de ambiente do Fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
end

# 1.2 DIRS_NIVEL 1
set -gx WWW "$HOME/www"
set -gx DOTFILES "$WWW/dotfiles"

# 2. APP_SYS_PC_01
set -gx APP_SYS_PC_01 "$DOTFILES/app_sys_pc_01"
set -gx BASHRC "$APP_SYS_PC_01/bash"
set -gx BOOTSTRAP_DEPS "$APP_SYS_PC_01/bootstrap_deps"
set -gx ENVS "$APP_SYS_PC_01/env"
set -gx ALIASES "$APP_SYS_PC_01/aliases"
set -gx FUNCS "$APP_SYS_PC_01/functions/"
set -gx CONFIG_CUSTOM_FISH "$DOTFILES/.config/fish/config_custom.fish"

# ULTIMOS: SYSTEMS
set -gx EXECUTE_FUNCTION_FINAL_BOOSTRAP "attGit" # ARRAY DE FUNCOES A EXECUTAR NO FIN DO bootstrap() exemplo: "func1 func 2"
set -gx CONFIG_HOME "$HOME/.config/"
set -gx CONFIG_DOTFILES "$HOME/.config/fish"

# 3. INCLUDED PROGRAMS :: PREFIX: O = OPEN DIR
set -gx PROGRAMS "$CONFIG_HOME"
set -gx OVIM "$PROGRAMS/vim"
set -gx ONVIM "$PROGRAMS/nvim"
set -gx OTMUX "$PROGRAMS/tmux"
set -gx OSTARSHIP "$PROGRAMS/starship"
set -gx OSF "$PROGRAMS/superfile"
set -gx OALACRITTY "$PROGRAMS/alacritty"
set -gx OFISH "$PROGRAMS/fish"

# Array para automacao via gitall (Fish equivalente)
set -gx ARRAY_BY_GITALL "$WWW" "$OVIM" "$ONVIM" "$OTMUX" "$OSTARSHIP" "$OSF" "$OALACRITTY" "$OFISH"

# Sobreescreve vars do sistema
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

# Define o ROOT_SHELL para o Fish se já não estiver definido
if test -z "$ROOT_SHELL"
    set -gx ROOT_SHELL "/usr/bin/fish"
end


# ==============================================================================
# MODO VIM NO SHELL - TEMINAL FISH
# Ativa o modo Vi nativo do Fish
fish_vi_key_bindings

# Mapeia 'jj' para voltar instantaneamente ao modo normal a partir do modo de inserção
bind -M insert -m default jj force-repaint

# (Opcional) Define o cursor para mudar de formato dependendo do modo (Bloco no Normal, Linha no Inserir)
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_visual underscore

# ------------------------------------------------------------------------------




# ==============================================================================
# @README
# ------------------------------------------------------------------------------
# @ATENCAO: 
    # - Sempre use este padrao em todos files,
    # - antes de mudancas leia este #@README, não faça mudancas sem avisar, nem marretacoes sem a autorização do proprietário.

# @objetivo_file: inicializar variaveis e funcoes do sistema no Fish
# @requisitos_essenciais: fish shell 3+, permissoes de leitura nos arquivos importados
# @regras: manter declaracao de variaveis no topo e imports no final
# @erros_ocorridos: variaveis nao exportadas antes do array do gitall
# @como_resolveu: definicao estruturada das vars de programs antes do array
# @diferencial_paea_funcionar: uso de set -gx para persistencia nas sessoes
# @importante_nao_mudar: a ordem de carregamento dos arquivos declarativos
# @todo_temQueArrumar: nenhum
# @EVITE: chamada direta de scripts sem checagem de existencia
# -- @CUIDADOS: Manter caminhos relativos baseados na variavel WWW
# @tags: #www #wAPP_SYS_PC_01 #vibecode #fish
# ==============================================================================

# 1. Carrega dados sensiveis do .env_rz
if test -f "$ENVS/.env_rz"
    for line in (cat "$ENVS/.env_rz" | grep -v '^#' | grep -v '^$')
        set -l clean_line (string replace -r '^export\s+' '' $line)
        set -l item (string split -m 1 '=' $clean_line)
        if test (count $item) -eq 2
            set -gx $item[1] (string trim -c '"\'' $item[2])
        end
    end
end

# 2. Carrega aliases do Fish
if test -f "$ALIASES/aliases.fish"
    source "$ALIASES/aliases.fish"
end

# 3. Carrega as customizacoes do usuario (config_custom.fish) se existir
if test -f "$CONFIG_CUSTOM_FISH"
    source "$CONFIG_CUSTOM_FISH"
end