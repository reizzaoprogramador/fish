# @file: $OFISH/config.fish
# @mission: configuracao + inicializacao + padronizacao de ambiente WWW

if status is-interactive
    set -g fish_greeting
end

# 1. DIRS_NIVEL 1
set -gx CONFIG_HOME "$HOME/.config"
set -gx ROOT_PC "$CONFIG_HOME/.01_ROOT"

# 2.1 ROOT_PC >> PC
set -gx PC "$ROOT_PC/01_PC_PGM_01"
set -gx OBASH "$PC/bash"
set -gx DOTFILES "$PC/dotfiles"
set -gx BOOTSTRAP_DIR "$PC/bootstrap"

# WWW - GITHUBS
set -gx GITHUB_RZ "$PC/github_rzj"
set -gx WWW_CLIS "$ROOT_PC/wgithub_clis"

# 2. IN ~/CONFIG :: PREFIX: O = OPEN DIR
set -gx PROGRAMS_CONFIG "$CONFIG_HOME"
set -gx OVIM "$PROGRAMS_CONFIG/vim"
set -gx ONVIM "$PROGRAMS_CONFIG/nvim"
set -gx OTMUX "$PROGRAMS_CONFIG/tmux"
set -gx OSTARSHIP "$PROGRAMS_CONFIG/starship"
set -gx OSF "$PROGRAMS_CONFIG/superfile"
set -gx OFISH "$PROGRAMS_CONFIG/fish"
set -gx OYAZI "$PROGRAMS_CONFIG/yazi"
set -gx OI3 "$PROGRAMS_CONFIG/i3"

# 3. SHELLBASH
set -gx ENVS "$OBASH/env"
set -gx ALIASES "$OBASH/aliases"
set -gx FUNC "$OBASH/functions"
set -gx FUNC_SH "$OBASH/functions/"

# 4. Array para automacao via gitall >> que tem que ser ate 3 niveis
set -gx ARRAY_BY_GITALL "$PC" "$WWW_CLIS" "$CONFIG_HOME"

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

# 1. Carrega dados sensiveis e ambiente (.env_rz)
if test -f "$ENVS/.env_rz"
    for line in (cat "$ENVS/.env_rz" | grep -v '^#' | grep -v '^$')
        set -l clean_line (string replace -r '^export\s+' '' $line)
        set -l item (string split -m 1 '=' $clean_line)
        if test (count $item) -eq 2
            set -gx $item[1] (string trim -c '"\'' $item[2])
        end
    end
end

# 2. == HOOKS ==
# 2.1 TMUX
set -gx LISTEN_TMUX "$HOME/.config/tmux/session_state.txt"  # SALVA JANELAS TMUX EM FILE.txt
# -- Detecção de Sessão Ativa (Opcional). O Tmux define automaticamente a variável $TMUX quando você está dentro dele. Se em algum script ou configuração futura você precisar validar se o shell atual está rodando dentro do Tmux --
if test -n "$TMUX"
    # Comandos específicos rodando dentro do tmux
end

# HOOK EXECUTADOR AO LIGAR E DESLIGAR
function __on_exit --on-event fish_exit
    persistSessionTmux save
end


# 3. Carrega aliases do Fish (ou compativel)
if test -f "$ALIASES/aliases.fish"
    source "$ALIASES/aliases.fish"
end

# 4. Carrega apenas arquivos .fish da pasta functions (equivalente ao loop de .sh)
if test -d "$FUNC"
    for file in "$FUNC"/*.fish
        if test -f "$file" -a -r "$file"
            source "$file"
        end
    end
end

# 4. Carrega Bootstrap (ele mesmo define suas variáveis e dependências internamente)
if test -f "$BOOTSTRAP_DIR/main.fish"
    source "$BOOTSTRAP_DIR/main.fish"
end


# ==============================================================================
# @README
# ------------------------------------------------------------------------------
# @ATENCAO: 
    # - Sempre use este padrao em todos files,
    # - antes de mudancas leia este #@README, não faça mudancas sem avisar, nem marretacoes sem a autorização do proprietário.

# @objetivo_file: inicializar variaveis e funcoes do sistema no Fish
# @requisitos_essenciais: fish 3+, permissoes de leitura nos arquivos importados
# @regras: manter declaracao de variaveis no topo e imports no final
# @como_resolveu: espelhamento completo do .bashrc_custom para o ecossistema Fish, mantendo caminhos atualizados do ROOT_PC
# @diferencial_paea_funcionar: adaptacao de arrays nativos do fish e loop de parsing do .env_rz
# @importante_nao_mudar: a ordem de carregamento dos arquivos declarativos
# @todo_temQueArrumar: nenhum
# @EVITE: chamar source config.fish dentro de funcoes filhas
# -- @CUIDADOS: Manter caminhos relativos baseados na variavel WWW e ROOT_PC
# @tags: #www #wAPP_SYS_PC_01 #vibecode #fish
# ==============================================================================