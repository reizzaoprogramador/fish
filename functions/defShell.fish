# ==============================================================================
# @file: defShell.fish
# @mission: Configurar o Fish como shell padrao do usuario de forma automatizada
# ==============================================================================
function defShell --description "Configura o Fish como shell padrão usando \$MY_SUDO_PASS"
    echo "$MY_SUDO_PASS" | sudo -S chsh -s (which fish) "$USER"; and echo "[OK] Shell padrao alterado para Fish com sucesso!"
end

# ==============================================================================
# @README_Plugin
# - O que está incluído: Função defShell em Fish para atualizar o shell padrão.
# - Regras: Funções no topo, uso do operador estrito and.
# - Tags: #contexto #wfunc #automacao
# ==============================================================================
