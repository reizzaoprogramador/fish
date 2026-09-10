

function offg
    # @desc: Executa gitall(), salva o tmux e desliga o computador com segurança usando $MY_SUDO_PASS
    # @mission: Automatiza o commit geral, a persistência de sessões e o desligamento do sistema
    
    if type -q gitall
        gitall
    else
        echo "Aviso: função gitall não encontrada. Prosseguindo..."
    end

    if type -q persistSessionTmux
        persistSessionTmux save
    end
    
    echo "$MY_SUDO_PASS" | sudo -S shutdown -h now
    
# =============================================================
# @How_To_Use
# offg
# ===========================================================
end