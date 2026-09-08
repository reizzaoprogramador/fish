#!/usr/bin/env fish
# @file: nvimLogs.fish
# @mission: configuracao + inicializacao + padronizacao de ambiente

function nvimLogs
    # @desc: Captura os logs do Neovim e exibe o status no terminal
    # @mission: Evitar exibicao de arquivo vazio e garantir diagnostico correto

    set -l logFile "$HOME/temp_nvimLogs.txt"

    # Remove o arquivo antigo caso exista
    test -f "$logFile"; and rm -f "$logFile"

    # Executa o Neovim headless para capturar o carregamento
    env TERM=dumb timeout 3s nvim -V1"$logFile" --headless +qa > /dev/null 2>&1

    if test -s "$logFile"
        echo "Logs gerados com sucesso em $logFile:"
        cat "$logFile"
    else
        echo "Nenhum erro detectado! O Neovim inicializou limpo."
    end
end

# =============================================================
# @How_To_Use
# nvimLogs

# =============================================================

# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE: 
# - Usa 'test -s' para verificar se o arquivo de log contem conteudo antes de exibir.
# - Evita alertas falsos de arquivo vermelho ou inexistente.
# ==============================================================================