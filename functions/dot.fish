# ==============================================================================
# @file: dot.fish
# @mission: Aplicar o stow em $DOTFILES limpando os links anteriores e resolvendo conflitos
# ==============================================================================
function dot --description "Aplica o stow diretamente em \$DOTFILES com limpeza prévia e tratamento de conflitos"
    if test -z "$DOTFILES"
        echo "[ERRO] Variavel DOTFILES nao esta definida!" >&2
        return 1
    end

    set -l target_dir "$DOTFILES"
    set -l ignore_patterns "zzz" ".git" "app_sys_pc_01" "README.md"
    set -l stow_ignore_args
    for pattern in $ignore_patterns
        set stow_ignore_args $stow_ignore_args "--ignore=$pattern"
    end

    if test -d "$target_dir"
        set -l dir_name (basename "$target_dir")
        set -l parent_dir (dirname "$target_dir")
        
        echo "[INFO] Limpando links anteriores (stow -D)..."
        set -l unstow_output (stow -D -v $stow_ignore_args -t "$HOME" -d "$parent_dir" "$dir_name" 2>&1)

        # Trata conflitos no unstow (ex: .viminfo)
        for line in $unstow_output
            if string match -q -- "*existing target is neither a link nor a directory:*" $line
                set -l conflict_rel (string split -m 1 ":" $line)[2] | string trim
                set -l absolute_target "$HOME/$conflict_rel"
                
                if test -e "$absolute_target"
                    echo "[FIX] Removendo obstáculo (unstow): $absolute_target"
                    rm -rf "$absolute_target"
                end
            end
        end

        echo "[+] Aplicando stow (stow -R) em: $dir_name"
        
        set -l stow_output (stow -v -R $stow_ignore_args -t "$HOME" -d "$parent_dir" "$dir_name" 2>&1)
        set -l stow_status $status
        
        if test $stow_status -ne 0
            echo "$stow_output"
            echo "[AVISO] Conflito detectado. Removendo obstáculos..."
            
            for line in $stow_output
                if string match -q -- "*existing target is neither a link nor a directory:*" $line
                    set -l conflict_rel (string split -m 1 ":" $line)[2] | string trim
                    set -l absolute_target "$HOME/$conflict_rel"
                    
                    if test -e "$absolute_target"
                        echo "[FIX] Removendo obstáculo: $absolute_target"
                        rm -rf "$absolute_target"
                    end
                end
            end
            
            echo "[+] Reaplicando stow com sucesso..."
            stow -v -R $stow_ignore_args -t "$HOME" -d "$parent_dir" "$dir_name"; and echo "[OK] Sucesso em: $dir_name"
        else
            echo "$stow_output"
            echo "[OK] Sucesso em: $dir_name"
        end
    else
        echo "[AVISO] Diretorio DOTFILES nao encontrado: $target_dir" >&2
        return 1
    end
end

# =============================================================
# @How_To_Use
# dot
# ===========================================================

# ==============================================================================
# @README_Plugin
# - O que está incluído: Função dot em Fish com tratamento de conflitos no stow e unstow.
# - Regras: Funções no topo, uso do operador estrito and.
# - Tags: #contexto #wfunc #automacao
# ==============================================================================