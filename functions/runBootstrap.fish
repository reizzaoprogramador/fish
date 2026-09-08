# @file: ~/.config/fish/functions/runBootstrap.fish
# @mission: executa o bootstrap do ambiente no shell Fish

function runBootstrap
    # @desc: Executa o script de bootstrap do ambiente
    # @mission: Rodar o instalador declarativo de dependências do shellbash
    bash ~/.config/shellbash/executables/bootstrap.sh
end

# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE: Função Fish equivalente ao runBootstrap do Bash.
# - Como Usar: Digite `runBootstrap` no terminal fish para disparar o instalador.
# ==============================================================================