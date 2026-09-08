#!/usr/bin/env fish
# @file: alacrittyFish.fish
# @mission: configuracao + inicializacao + padronizacao de ambiente

function alacrittyFish
    # @desc: garante a variavel TERM e o shell padrao sem sobrescrever configuracoes manuais do alacritty.toml
    # @mission: manter o alacritty.toml intacto preservando atalhos e temas do usuario

    set -l ALACRITTY_CONF "$HOME/.config/alacritty/alacritty.toml"
    set -l FISH_BIN "/usr/bin/fish"

    # 1. Garante TERM universal no Fish
    set -Ux TERM xterm-256color

    # 2. Define o Fish como shell padrao do usuario se necessario
    if test "$SHELL" != "$FISH_BIN"; and test -f "$FISH_BIN"
        chsh -s "$FISH_BIN"; and echo "Fish definido como shell padrao via chsh."
    end

    # 3. Se o arquivo existir, verifica se ja possui a config de TERM
    if test -f "$ALACRITTY_CONF"
        if not grep -q 'TERM = "xterm-256color"' "$ALACRITTY_CONF"
            echo "" >> "$ALACRITTY_CONF"
            echo "[env]" >> "$ALACRITTY_CONF"
            echo 'TERM = "xterm-256color"' >> "$ALACRITTY_CONF"
            echo "Variavel TERM adicionada ao alacritty.toml existente."
        else
            echo "Alacritty ja esta configurado com o TERM correto."
        end
    else
        echo "Aviso: $ALACRITTY_CONF nao encontrado."
    end
end

alacrittyFish

# ==============================================================================
# @README_FILE
# ------------------------------------------------------------------------------
# @leia_antes: antes de mudancas leia este #@README_FILE, não faça mudancas sem avisar, nem marretacoes sem a autorização do proprietário.
# @objetivo_file: injetar TERM com seguranca sem destruir customizacoes do usuario no alacritty.toml nativo
# @requisitos_essenciais: Alacritty, Fish Shell
# @regras: Funcoes no topo, operadores estritos (and)
# @tags: #alacritty #fish #wfunc #automacao
# ==============================================================================