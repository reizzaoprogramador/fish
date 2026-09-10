#!/bin/fish
# @file: linksHome.fish
# @mission: configuracao + inicializacao + padronizacao de ambiente

function linksHome
    # @desc: Cria links simbólicos diretos na home de todos os arquivos/pastas em $DOTFILES sem stow e executa installFonts ao final
    # @mission: Varrer $DOTFILES (incluindo ocultos), ignorar itens da lista, linkar na home e chamar installFonts

    # Declaração do array de ignorados no Fish
    set -gx ARRAY_DOTFILES_IGNORE "zzz" "test"

    if test -z "$DOTFILES"
        echo "[ERRO] Variável \$DOTFILES não está definida."
        return 1
    end

    if not test -d "$DOTFILES"
        echo "[ERRO] O diretório \$DOTFILES ($DOTFILES) não existe."
        return 1
    end

    echo "[INFO] Iniciando criação de links simbólicos diretos na Home..."

    # Usando find para pegar o primeiro nível de itens corretamente (incluindo ocultos)
    for item in (find "$DOTFILES" -mindepth 1 -maxdepth 1)
        set basename (basename "$item")

        # Verifica se está no array de ignorados
        if contains -- "$basename" $ARRAY_DOTFILES_IGNORE
            echo "[IGNORADO] $basename está na lista de exclusão."
            continue
        end

        set target_link "$HOME/$basename"

        # Trata conflitos e remove links/arquivos antigos antes de criar o novo
        if test -L "$target_link"
            rm "$target_link"
        else if test -e "$target_link"
            echo "[AVISO] $target_link já existe como arquivo/pasta real. Removendo para linkar..."
            rm -rf "$target_link"
        end

        # Cria o link simbólico direto
        if ln -s "$item" "$target_link"
            echo "[SUCESSO] Link criado -> ~/$basename aponta para $item"
        else
            echo "[FALHA] Não foi possível criar o link para $basename"
        end
    end

    echo "[+] Processo de linkagem direta concluído com feedback!"

    # Executa a função installFonts ao final, se ela existir
    if functions -q installFonts
        echo "[INFO] Executando installFonts()..."
        installFonts
    else
        echo "[AVISO] A função installFonts não está definida no escopo atual."
    end

# =============================================================
# @How_To_Use
# linksHome
# 
# ===========================================================
end

# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE: Função em Fish para linkagem direta de dotfiles via ln -s,
#                      chamando installFonts() automaticamente ao terminar.
#
# ==============================================================================