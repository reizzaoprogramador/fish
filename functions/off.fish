function off
    # @desc: Salva o tmux explicitamente e desliga o computador com segurança usando $MY_SUDO_PASS
    # @mission: Garante a persistência do tmux e executa o desligamento imediato e seguro
    
    if type -q persistSessionTmux
        persistSessionTmux save
    end
    
    echo "$MY_SUDO_PASS" | sudo -S shutdown -h now
    
# =============================================================
# @How_To_Use
# off
# ===========================================================
end
