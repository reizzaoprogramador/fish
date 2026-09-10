function bbb --description "Recarrega o ambiente Fish com teste e feedback"
    # @desc: recarrega o ambiente fish com teste e feedback
    # @mission: executar testShell, aplicar source e reiniciar o shell
    clear
    
    # Executa a função externa testShell se ela existir no escopo do Fish
    if type -q testShell
        testShell
    end
    
    # Recarrega a configuração principal do Fish
    if test -f "$HOME/.config/fish/config.fish"
        source "$HOME/.config/fish/config.fish"
    end
    
    # Imprime o feedback formatado
    set_color green --bold
    echo "[OK] SOURCE & EXEC :: [FISH] :: SUCESS !!! $testShell"
    set_color normal
    
    # Reinicia o shell de forma limpa (DEVE SER A ÚLTIMA LINHA)
    exec fish
    
# =============================================================
# @How_To_Use
# bbb
# ===========================================================
end

# ==============================================================================
# @README_Plugin
# - O que está incluído: Função bbb para recarregar o Fish com teste e feedback visual.
# - Comportamento: Limpa a tela, roda testShell (se existir), recarrega o config.fish, exibe o status e executa o exec fish.
# - Como Usar: bbb
# - Tags: #contexto #wfunc #automacao #fish
# ==============================================================================