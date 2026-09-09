function offg
    # @desc: Executa gitall() antes e desliga o computador com segurança
    # @mission: Automatiza o salvamento/commit geral via git e desliga o sistema na sequência
    
    if type -q gitall
        gitall && sudo shutdown -h now
    else
        echo "Aviso: função gitall não encontrada. Desligando sem gitall..." && sudo shutdown -h now
    end
    
# =============================================================
# @How_To_Use
# offg
# ===========================================================
end
