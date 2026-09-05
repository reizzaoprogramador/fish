# @file: $FUNCTIONS/fishfunctions/linksPontuais.fish
# @mission: Garantir o mapeamento exato e espelhado de $OFISH para ~/.config/fish

function linksPontuais
    # @desc: Função para forçar o link simbólico seguro de $OFISH para ~/.config/fish
    # @mission: Validar caminhos, proteger o repositório, limpar destino antigo e linkar com suporte a funções
    
    # Blindagem absoluta: o destino é SEMPRE a pasta de config real do usuário
    set -l target_config "$HOME/.config/fish"
    
    if test -z "$DOTFILES"; or test -z "$OFISH"; or test -z "$FUNCS"
        echo "[ERRO] As variáveis \$DOTFILES, \$OFISH ou \$FUNCS não estão definidas."
        return 1
    end

    # Proteção de segurança contra caminhos incorretos
    if string match -q "$DOTFILES*" "$target_config"
        echo "[ERRO CRÍTICO] O destino do link aponta para dentro do dotfiles! Abortando."
        return 1
    end

    # 1. Garante a estrutura física no repositório
    if not test -d "$OFISH"
        mkdir -p "$OFISH"
    end

    # Cria um config.fish básico de segurança se não existir
    if not test -f "$OFISH/config.fish"
        echo '# @file: $OFISH/config.fish' > "$OFISH/config.fish"
        echo 'if status is-interactive' >> "$OFISH/config.fish"
        echo '    set -g fish_greeting' >> "$OFISH/config.fish"
        echo 'end' >> "$OFISH/config.fish"
    end

    # 2. Remove o link ou diretório anterior em ~/.config/fish
    if test -d "$target_config"; or test -L "$target_config"
        rm -rf "$target_config"
    end

    # 3. Garante o diretório pai (~/.config)
    set -l config_parent (dirname "$target_config")
    if not test -d "$config_parent"
        mkdir -p "$config_parent"
    end

    # 4. Cria o link simbólico principal da pasta fish
    ln -sfn "$OFISH" "$target_config"

    # 5. GARANTIA DE ESPELHAMENTO DAS FUNÇÕES:
    # Cria um link interno da pasta de funções globais para dentro do config do fish, 
    # garantindo que tudo em $FUNCS/fishfunctions apareça automaticamente no fish.
    if test -d "$FUNCS/fishfunctions"
        if not test -d "$target_config/functions"; and not test -L "$target_config/functions"
            ln -sfn "$FUNCS/fishfunctions" "$target_config/functions"
        end
    end
    
    echo "[OK] Links pontuais aplicados com sucesso!"
    echo "    Origem ($OFISH) -> Destino ($target_config)"
    echo "    Funções espelhadas de ($FUNCS/fishfunctions)"

# =============================================================
# @How_To_Use
# Use_1: linksPontuais      # Aplica os links espelhando config e funções corretamente
# ===========================================================
end

# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE: 
# - Funções no topo, operadores estritos.
# - Garante o symlink do core do fish e cria um sub-link inteligente para a pasta de funções.
# ==============================================================================