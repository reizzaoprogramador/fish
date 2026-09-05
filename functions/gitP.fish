# ==============================================================================
# @file: gitP.fish
# @mission: Git pontual com add all automático, branch default main e push seguro no Fish.
# ==============================================================================

function gitP
    # @desc: Uso: gitP "mensagem do commit" [branch]
    set -l msg "$argv[1]"
    set -l branch "$argv[2]"

    # Se a branch nao for informada ($argv[2] vazio), assume 'main' por default
    if test -z "$branch"
        set branch "main"
    end

    if test -z "$msg"
        set_color red --bold
        echo "[ERRO] Informe a mensagem do commit entre aspas."
        set_color normal
        echo "Uso: gitP \"sua mensagem de commit\" [branch]"
        return 1
    end

    set_color blue
    echo "[INFO] Adicionando todas as alteracoes (git add .)..."
    set_color normal

    # 1. Adiciona tudo e faz o commit e o push usando operadores estritos (and)
    git add .
    and begin
        set_color blue
        echo "[INFO] Realizando commit..."
        set_color normal
        git commit -m "$msg"
    end
    and begin
        set_color blue
        echo "[INFO] Enviando para o repositorio remoto (branch: $branch)..."
        set_color normal
        git push origin "$branch"
    end
    and begin
        set_color green --bold
        echo "[OK] Git pontual executado com sucesso!"
        set_color normal
    end
    or begin
        set_color red --bold
        echo "[ERRO] Falha no fluxo do gitP."
        set_color normal
        return 1
    end
end

# ==============================================================================
# @README_Plugin
# - O que está incluído: Função gitP otimizada para Fish com add all, branch padrão main e push automatizado.
# - Como Usar: gitP "Minha alteração" [opcional: nome-da-branch]
# ==============================================================================
# @regras
# - Proibido marretas/mudanças sem avisar o dono.
# - Operadores estritos (and).
# - Apenas instalar/executar se necessário, sem sobrescrever o que já está ok.
# ==============================================================================