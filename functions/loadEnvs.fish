#!/bin/fish
# @file: ~/.config/fish/functions/loadEnvs.fish
# @mission: ler e carregar variaveis de ambiente do arquivo de envs compartilhado

function loadEnvs
    # @desc: Carrega variaveis de ambiente globais para a sessao fish
    # @mission: Importar definicoes de arquivos .env de forma segura
    if test -f "$HOME/dotgit/envs/.env_shells"
        export (grep -v '^#' "$HOME/dotgit/envs/.env_shells" | grep -v '^[[:space:]]*$' | xargs)
    end
# =============================================================
# @How_To_Use
# loadEnvs
# ===========================================================
end
# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE:
# - Suporta linhas no formato VAR=VALOR e export VAR=VALOR.
# - Remove aspas simples e duplas automaticamente dos valores.
# - As variaveis sao exportadas globalmente (-gx), ficando visiveis no Fish e subprocessos.
# ==============================================================================