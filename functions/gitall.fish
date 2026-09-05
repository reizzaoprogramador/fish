# @file: gitall.fish
# @mission: Automatizar rastreamento profundo via find, commit, pull/rebase e push em todos os repositorios do ARRAY_BY_GITALL

function get_git_dirs
    set -l dirs
    set -l target_list $ARRAY_BY_GITALL

    if test (count $target_list) -eq 0
        set target_list "$WWW"
    end

    for base_path in $target_list
        if test -d "$base_path"
            for git_dir in (find "$base_path" -maxdepth 3 -name ".git" -type d 2>/dev/null)
                set -a dirs (dirname "$git_dir")
            end
        end
    end

    # Remove duplicadas e imprime ordenado
    printf "%s\n" $dirs | sort -u
end

function gitrr --description "Sincroniza todos os repositorios encontrados recursivamente"
    set -l msg $argv[1]
    if test -z "$msg"
        set msg "update: sincronizacao automatica "(date +'%Y-%m-%d %H:%M')
    end

    set -l dirs (get_git_dirs)

    if test (count $dirs) -eq 0
        echo "⚠️ Nenhum repositório com pasta .git/ foi encontrado."
        return 1
    end

    for dir_path in $dirs
        if test -d "$dir_path/.git"
            echo ""
            echo "🚀 [GIT] Repositório: $dir_path"

            # Executa em subshell para preservar o pwd do terminal
            begin
                cd "$dir_path"

                if test -d ".git/rebase-merge"; or test -d ".git/rebase-apply"
                    echo "⚠️ Rebase pendente detectado. Abortando..."
                    git rebase --abort >/dev/null 2>&1; or true
                end

                git add -A

                if test -n "$(git status --porcelain)"
                    git commit -m "$msg"
                else
                    echo "✨ Nada para commitar."
                end

                echo "🔄 Sincronizando com remoto..."
                if not git fetch >/dev/null 2>&1
                    echo "❌ Falha ao conectar ao servidor remoto no diretório $dir_path"
                    continue
                end

                if not git pull --rebase >/dev/null 2>&1
                    echo "⚠️ Falha no rebase. Tentando alinhar ramificação..."
                    git rebase --abort >/dev/null 2>&1; or true
                    git pull --no-rebase >/dev/null 2>&1; or true
                end

                set -l current_branch (git branch --show-current)
                if test -z "$current_branch"
                    set current_branch "main"
                end

                if not git push origin $current_branch >/dev/null 2>&1
                    echo "⚠️ Configurando upstream automaticamente..."
                    git push --set-upstream origin $current_branch >/dev/null 2>&1; or true
                end

                echo "✅ Repositório atualizado com sucesso."
            end
        end
    end

    echo ""
    set_color green --bold
    echo "[OK] AMBIENTE FISH: Execucao do gitall concluida com sucesso !!!"
    set_color normal
end

function gitall --description "Alias para gitrr"
    gitrr $argv[1]
end

# =============================================================
# @Como_Usar
# Uso_1: gitall "mensagem opcional"
# Uso_2: gitrr "mensagem opcional"
# =============================================================

# ==============================================================================
# @README
# ------------------------------------------------------------------------------
# @objetivo_file: varredura profunda com find (maxdepth 3) baseada no ARRAY_BY_GITALL
# @tags: #git #sync #fish #recursive
# ==============================================================================