# ==============================================================================
# @file: installFonts.fish
# @mission: Atualizar o cache e instalar/registrar as fontes presentes em ~/.fonts no Fish
# ==============================================================================

function installFonts
    set -l fonts_dir "$HOME/.fonts"

    if not test -d "$fonts_dir"
        set_color red --bold
        echo "[ERRO] Diretorio de fontes nao encontrado: $fonts_dir"
        set_color normal
        return 1
    end

    set_color blue
    echo "[INFO] Atualizando cache de fontes do sistema a partir de $fonts_dir..."
    set_color normal

    # Atualiza o cache de fontes e valida com operadores estritos (and / or)
    fc-cache -f -v
    and begin
        set_color green --bold
        echo "[OK] Fontes instaladas e cache atualizado com sucesso!"
        set_color normal
    end
    or begin
        set_color red --bold
        echo "[ERRO] Falha ao atualizar o cache de fontes via fc-cache."
        set_color normal
        return 1
    end
end

# ==============================================================================
# @README_Plugin
# - O que está incluído: Função installFonts para registrar fontes de ~/.fonts no Fish.
# - Como Usar: installFonts
# ==============================================================================
# @regras
# - Proibido marretas/mudanças sem avisar o dono.
# - Operadores estritos (and).
# - Apenas instalar/executar se necessário, sem sobrescrever o que já está ok.
# ==============================================================================