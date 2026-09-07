#!/usr/bin/env fish
# @file: nvimLogs.fish
# @mission: configuracao + inicializacao + padronizacao de ambiente

function nvimLogs
    # @desc: Remove o log anterior caso exista e captura os erros da inicializacao do Neovim
    # @mission: Garantir a recriacao limpa de ~/temp_nvimLogs.txt sem acúmulo de logs passados

    set -l logFile "$HOME/temp_nvimLogs.txt"

    test -f "$logFile"; and rm -f "$logFile"

    timeout 3s nvim -V1"$logFile" --headless +qa > /dev/null 2>&1; and \
    echo "Logs novos salvos com sucesso em: $logFile"
end

# =============================================================
# @How_To_Use
# nvimLogs

# =============================================================

# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE: 
# - Operadores estritos (and).
# - Valida a existência prévia do arquivo com 'test -f' no padrão nativo do Fish.
# ==============================================================================