# ==============================================================================
# @file: nvim_clean.fish
# @mission: Limpar cache do LuaJIT, registros ShaDa e cache temporário do Neovim
# ==============================================================================
function nvimClean --description "Limpa cache do LuaJIT, registros ShaDa e cache temporário do Neovim"
    echo "🧹 Limpando cache do LuaJIT, registros ShaDa e cache temporário..."
    rm -rf "$HOME/.local/share/nvim/luajit-cache" \
           "$HOME/.local/state/nvim/shada" \
           "$HOME/.cache/nvim"; and \
    echo "✨ Cache limpo com sucesso! Pronto para voar."
end

# ==============================================================================
# @README_Plugin
# - O que está incluído: Função nvimClean para Fish Shell.
# - Comportamento: Remove diretórios de cache locais do Neovim utilizando operadores lógicos estritos (and).
# - Como usar: `nvimClean`
# - @importante: se mudar o nome desta funcao edite tbm as funcoes que a usam.
# ==============================================================================
