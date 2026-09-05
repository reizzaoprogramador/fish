# ==============================================================================
# @file: catDir.fish
# @mission: Concatenar e exibir o conteudo de arquivos de um diretorio com suporte a caminho opcional
# ==============================================================================
function catDir --description "Concatena o conteudo de arquivos aceitando diretorio e profundidade opcionais"
    set -l target_dir "."
    set -l max_depth 3
    set -l user_ignores

    # Se o primeiro argumento for um diretorio valido
    if test (count $argv) -gt 0; and test -d $argv[1]
        set target_dir $argv[1]
        set argv $argv[2..-1]
    end

    # Se o proximo argumento for um numero (profundidade)
    if test (count $argv) -gt 0; and string match -qr '^[0-9]+$' $argv[1]
        set max_depth $argv[1]
        set argv $argv[2..-1]
    end

    set user_ignores $argv

    set -l default_ignores \
        ".git" "*zzz*" "node_modules" "__pycache__" ".cache" ".next" "dist" "build" \
        "*.lock" "package-lock.json" "*.tmp" "*.swp" "*.log" \
        "*.png" "*.jpg" "*.jpeg" "*.gif" "*.pdf" "*.zip" "*.tar*" "*.exe" "*.so"

    set -l all_ignores $default_ignores $user_ignores

    set -l prune_args
    for item in $all_ignores
        set prune_args $prune_args -name "$item" -o -path "*/$item/*" -o -path "*/$item" -o
    end

    if test (count $prune_args) -gt 0
        set -e prune_args[-1]
    end

    find "$target_dir" -maxdepth "$max_depth" \( \( $prune_args \) -prune \) -o -type f -print | while read -l file
        cat "$file"; and echo ""
    end
end

# =============================================================
# @How_To_Use
# catDir
# catDir /caminho/pasta 2
# ===========================================================

# ==============================================================================
# @README_Plugin
# - O que está incluído: Função catDir em Fish com suporte a diretorio opcional.
# - Regras: Funções no topo, uso do operador estrito and.
# - Tags: #contexto #wfunc #automacao
# ==============================================================================
