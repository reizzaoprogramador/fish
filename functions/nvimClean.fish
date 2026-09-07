#!/usr/bin/env fish
# @file: nvimClean.fish
# @mission: configuracao + inicializacao + padronizacao de ambiente

function nvimClean
    # @desc: Limpa completamente caches, shada e temporarios do Neovim tratando wildcards no Fish
    # @mission: Eliminar arquivos temporarios e sessao acumulada sem falhar no globbing

    rm -rf $HOME/.cache/nvim; and \
    rm -rf $HOME/.local/state/nvim; and \
    rm -rf $HOME/.local/share/nvim; and \
    for file in $HOME/temp_nvimLogs*
        test -e "$file"; and rm -f "$file"
    end; and \
    echo "Ambiente e caches do Neovim limpos com sucesso!"
end

# =============================================================
# @How_To_Use
# nvimClean

# =============================================================

# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE: 
# - Utiliza loop for seguro para expandir wildcards sem disparar erro quando nao houver correspondencia.
# - Mantem operadores estritos (and).
# ==============================================================================