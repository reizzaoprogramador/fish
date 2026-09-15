#!/bin/bash
# @file: ~/.config/fish/functions/fnsh.fish
# @mission: carregar e executar funcoes bash sem subshell isolado / sem perda de parametros

function fnsh
    # @desc: Executa funcoes/scripts do $FUNC_SH garantindo repasse de argumentos
    # @mission: Carregar o arquivo .sh via bash e repassar todos os parametros exatamente como informados

    if test -z "$FUNC_SH"
        echo "❌ Erro: A variavel \$FUNC_SH nao esta definida."
        return 1
    end

    if not test -d "$FUNC_SH"
        echo "❌ Erro: O diretorio em \$FUNC_SH nao existe -> $FUNC_SH"
        return 1
    end

    set -l nomeFuncao $argv[1]
    set -e argv[1]

    if test -z "$nomeFuncao"
        echo "⚠️ Uso: fnsh <nomeFuncaoBash> [argumentos...]"
        return 1
    end

    set -l arquivoSh "$FUNC_SH/$nomeFuncao.sh"

    if not test -f "$arquivoSh"
        echo "❌ Erro: Arquivo nao encontrado -> $arquivoSh"
        return 1
    end

    echo "🚀 Executando '$nomeFuncao' via Bash..."

    # Executa o Bash importando o arquivo e invocando a funcao com os argumentos
    bash -c '
        arquivo="$1"
        funcao="$2"
        shift 2

        source "$arquivo" || exit 1

        if declare -f "$funcao" > /dev/null; then
            "$funcao" "$@"
        else
            bash "$arquivo" "$@"
        fi
    ' bash "$arquivoSh" "$nomeFuncao" $argv

    set -l statusFinal $status
    if test $statusFinal -ne 0
        echo "❌ [ERRO] Falha na execucao da funcao (codigo $statusFinal)."
        return $statusFinal
    end
end

# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE:
# - Se o gitall.sh usa variaveis de ambiente especificas ou funcoes auxiliares de outros arquivos,
#   elas precisam estar carregadas no arquivo gitall.sh (ex: source nas dependencias).
# - O comando passa os argumentos extras ($argv) diretamente para a funcao Bash invocada.
# ==============================================================================