#!/bin/fish
# @file: ~/.config/fish/config.fish
# @mission: configuracao + inicializacao + padronizacao de ambiente

if status is-interactive
    set -g fish_greeting # desativar a mensagem de boas-vindas (greeting) do Fish Shell sempre que você abre um novo terminal.
    loadEnvs
end

if test -n "$OALIASES"; and test -f "$OALIASES"
    for line in (grep -v '^[[:space:]]*#' "$OALIASES" | grep -v '^[[:space:]]*$')
        # Remove a palavra 'alias ' do inicio
        set clean_line (string replace -r '^alias\s+' '' -- $line)
        
        if test -z "$clean_line"
            continue
        end

        # Pula comandos condicionais reais
        if string match -q '*&&*' -- "$clean_line"; or string match -q '*||*' -- "$clean_line"; or string match -q 'test *' -- "$clean_line"
            continue
        end

        # Separa o nome e o valor pelo primeiro sinal de igual
        set parts (string split -m 1 '=' -- $clean_line)
        
        if test (count $parts) -eq 2
            set alias_name (string trim -- $parts[1])
            # Remove apenas a primeira e a última aspa da string inteira com segurança
            set alias_val (string replace -r '^["\'](.*)["\']$' '$1' -- $parts[2])
            
            alias $alias_name "$alias_val"
        end
    end
end

# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE:
# - Carrega a funcao loadEnvs na inicializacao interativa via autoload do fish.
# - Converte dinamicamente apenas os aliases simples do Bash apontados por $OALIASES, ignorando comandos complexos ou colchetes.
# ==============================================================================