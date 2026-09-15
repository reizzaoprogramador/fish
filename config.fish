#!/bin/fish
# @file: ~/.config/fish/config.fish
# @mission: configuracao + inicializacao + padronizacao de ambiente

if status is-interactive
    set -g fish_greeting # desativar a mensagem de boas-vindas (greeting) do Fish Shell sempre que você abre um novo terminal.
    loadEnvs
end

# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE:
# - Carrega a funcao loadEnvs na inicializacao interativa.
# - As variaveis de $HOME/dotgit/envs/.env_shells ficam prontas para uso.
# ==============================================================================
