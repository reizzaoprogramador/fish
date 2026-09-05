# ==============================================================================
# @file: uninstallApt.fish / @mission: Remover pacotes apt de forma limpa e purgada
# ==============================================================================
function uninstallApt
    # @desc: Remove um pacote via apt junto com --purge e autoremove para limpar dependências órfãs.
    # @mission: Garantir desinstalação sem deixar lixo no sistema.
    # ===================
    # @Como_Usar: uninstallApt nome_do_pacote
    
    set -l pacote $argv[1]

    if test -z "$pacote"
        echo "Erro: Nenhum pacote informado."
        echo "Uso: uninstallApt nome_do_pacote"
        return 1
    end

    echo "Removendo o pacote: $pacote..."
    sudo apt remove --purge "$pacote" -y && sudo apt autoremove -y
end