# ==============================================================================
# @file: bbb.fish
# @mission: Recarregar a sessão do Fish Shell e sincronizar as funções de wshells com feedback customizado.
# ==============================================================================

function bbb --description "Recarrega a sessao do Fish com feedback customizado"
    # @desc: Limpa a tela e sincroniza funções se necessário
    # @mission: Atualização rápida e limpa do ambiente interativo
    clear
    
    if test -f "$SHELLS/functions/bbb.fish"
        mkdir -p "$HOME/.config/fish/functions"
        cp "$SHELLS/functions/bbb.fish" "$HOME/.config/fish/functions/bbb.fish"
    end
    
    set_color green --bold
    echo "[OK] AMBIENTE FISH CARREGADO !!!"
    set_color normal
end

# ==============================================================================
# @README_Plugin
# - O que está incluído: Função bbb para recarregar o Fish Shell com feedback visual.
# - Comportamento: Limpa o terminal, sincroniza a função se necessário e exibe a mensagem de sucesso colorida.
# - Como Usar: bbb
# - Tags: #contexto #wfunc #automacao
# ==============================================================================