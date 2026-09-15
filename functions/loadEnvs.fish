#!/bin/fish
# @file: ~/.config/fish/functions/loadEnvs.fish
# @mission: ler e carregar variaveis de ambiente do arquivo de envs compartilhado

function loadEnvs
    # @desc: Carrega variaveis do arquivo .env_shells para o ambiente global do Fish
    # @mission: Ler $HOME/dotgit/envs/.env_shells, tratar a sintaxe Bash/Env e aplicar com set -gx

    set -l envFile "$HOME/dotgit/envs/.env_shells"

    if not test -f "$envFile"
        echo "⚠️ Arquivo de envs nao encontrado em: $envFile"
        return 1
    end

    while read -l line
        # Ignora linhas vazias e comentarios
        string match -r '^\s*#' "$line" >/dev/null && continue
        string match -r '^\s*$' "$line" >/dev/null && continue

        # Remove 'export ' do inicio da linha se existir
        set -l cleanLine (string replace -r '^\s*export\s+' '' -- "$line")

        # Separa a chave e o valor pelo primeiro sinal de '='
        set -l parts (string split -m 1 '=' -- "$cleanLine")

        if test (count $parts) -eq 2
            set -l varName (string trim -- $parts[1])
            set -l varValue (string trim -c '"' -c "'" -- $parts[2])

            # Expande variaveis do sistema como $HOME se existirem no valor
            eval set -gx $varName "$varValue"
        end
    end < "$envFile"
end

# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE:
# - Suporta linhas no formato VAR=VALOR e export VAR=VALOR.
# - Remove aspas simples e duplas automaticamente dos valores.
# - As variaveis sao exportadas globalmente (-gx), ficando visiveis no Fish e subprocessos.
# ==============================================================================