# @file: attG.fish
# @mission: Orquestrar a atualizacao global do ambiente e sincronizacao Git em cadeia no Fish.
#
# @desc:
# Encadeia as chamadas de bbb, attWDotfiles, attGit e gitall em sequencia fluida dentro do Fish Shell.
#
# @porque_funcionou:
# A utilizacao do operador 'and' garante que a proxima etapa do fluxo so seja executada
# se o passo anterior concluir sem erros.

function attG --description "Executa bbb, attWDotfiles, attGit e gitall em cadeia"
    set -l msg $argv[1]
    if test -z "$msg"
        set msg "atualizacao global: sincronizacao automatica do ambiente"
    end

    set_color blue --bold
    echo "[ATTG] Iniciando atualizacao global do ambiente..."
    set_color normal
    echo ""

    bbb; and astow; and attGit; and gitall "$msg"
end

# =============================================================
# @Como_Usar
# Uso_1: attG
# Uso_2: attG "mensagem personalizada do commit"
# =============================================================
