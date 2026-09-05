# @file: $FUNCTIONS/fishfunctions/wrapperPrograms.fish
# @mission: Roteamento centralizado de ferramentas utilizando caminhos modulares dedicados

function wrapperPrograms
    # @desc: Roteador centralizado para gerenciar a inicialização de ferramentas via caminhos modulares
    # @mission: Direcionar a execução de vim, nvim, tmux, fish, starship, spf e alacritty utilizando variáveis dedicadas
    
    set -l app $argv[1]
    set -l args $argv[2..-1]

    switch "$app"
        case "vim"
            command nvim -u "$OVIM/vimrc" $args
        case "nvim"
            command nvim -u "$ONVIM/init.vim" $args
        case "tmux"
            command tmux -f "$OTMUX/tmux.conf" $args
        case "starship"
            set -gx STARSHIP_CONFIG "$OSTARSHIP/starship.toml"
            command starship $args
        case "spf" "superfile"
            command spf $args
        case "alacritty"
            command alacritty --config-file "$OALACRITTY/alacritty.toml" $args
        case "fish"
            env XDG_CONFIG_HOME="$PROGRAMS" command fish -C "source $OFISH/config.fish" $args
        case '*'
            command $app $args
    end

# =============================================================
# @How_To_Use: included programs:
# Use_1: wrapperPrograms vim                  # Abre o vim lendo de $OVIM/vimrc
# Use_2: wrapperPrograms nvim                 # Abre o nvim lendo de $ONVIM/init.vim
# Use_3: wrapperPrograms tmux                 # Inicia o tmux lendo de $OTMUX/tmux.conf
# Use_4: wrapperPrograms starship             # Roda o starship com o toml em $OSTARSHIP/
# Use_5: wrapperPrograms spf                  # Abre o Superfile
# Use_6: wrapperPrograms alacritty            # Abre o Alacritty com config em $OALACRITTY/
# Use_7: wrapperPrograms fish                 # Inicia o fish carregando config de $OFISH/config.fish
# ===========================================================
end

# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE: 
# - Funções no topo, operadores estritos.
# - Roteador centralizado compatível com a sintaxe nativa do Fish.
# ==============================================================================