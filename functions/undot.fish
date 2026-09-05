# ==============================================================================
# @file: undot.fish
# @mission: Remover o stow diretamente do $DOTFILES
# ==============================================================================
function undot --description "Remove os links do stow (unstow) baseados em \$DOTFILES"
    if test -z "$DOTFILES"
        echo "[ERRO] Variavel DOTFILES nao esta definida!" >&2
        return 1
    end

    set -l target_dir "$DOTFILES"
    set -l dir_name (basename "$target_dir")
    set -l parent_dir (dirname "$target_dir")

    echo "[INFO] Removendo stow (unstow) para: $dir_name"
    stow -v -D -t "$HOME" -d "$parent_dir" "$dir_name"; and echo "[OK] Stow removido com sucesso de $dir_name"
end

# ==============================================================================
# @README_Plugin
# - O que está incluído: Função undot em Fish para desfazer links do $DOTFILES.
# - Regras: Funções no topo, uso do operador estrito and.
# - Tags: #contexto #wfunc #automacao
# ==============================================================================
