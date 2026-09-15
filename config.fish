#!/bin/fish
# @file: ~/.config/fish/config.fish
# @mission: configuracao + inicializacao + padronizacao de ambiente

if status is-interactive
    # desativar a mensagem de boas-vindas (greeting) do Fish Shell sempre que você abre um novo terminal.
    set -g fish_greeting 
end


# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE:
# - Arquivo redefinido para o estado padrao de fabrica.
# - As configuracoes nativas do Fish sao carregadas diretamente pelo binario.
# ==============================================================================