# @file: $FUNCTIONS/fishfunctions/replaceTerms.fish
# @mission: Substituir de forma segura e controlada um termo por outro recursivamente no diretório atual

function replaceTerms
    # @desc: Função utilitária blindada para refatoração e substituição profunda de strings
    # @mission: Validar argumentos, confirmar a operação e substituir recursivamente $argv[1] por $argv[2]
    
    set -l termoAntigo $argv[1]
    set -l termoNovo $argv[2]

    if test -z "$termoAntigo"; or test -z "$termoNovo"
        echo "[ERRO] Uso correto: replaceTerms <termo_antigo> <termo_novo>"
        echo "[INFO] Exemplo: replaceTerms DOTFILES O_DOTFILES"
        return 1
    end

    echo "[INFO] Buscando ocorrências de '$termoAntigo' para substituir por '$termoNovo'..."
    
    # Conta quantos arquivos contêm o termo antes de mexer
    set -l arquivos (grep -rl "$termoAntigo" . --exclude-dir=.git --exclude-dir=node_modules)

    if test (count $arquivos) -eq 0
        echo "[AVISO] Nenhuma ocorrência de '$termoAntigo' foi encontrada nos arquivos."
        return 0
    end

    echo "[INFO] Arquivos que serão modificados:"
    for arq in $arquivos
        echo "  -> $arq"
    end

    echo ""
    read -l -P "Deseja realmente aplicar a substituição nesses arquivos? [s/N] " confirm
    
    if test "$confirm" != "s"; and test "$confirm" != "S"
        echo "[CANCELADO] Operação abortada pelo usuário."
        return 0
    end

    # Executa a substituição com segurança apenas nos arquivos mapeados
    for arquivo in $arquivos
        # Utiliza delimitadores seguros (|) no sed para evitar conflito com barras
        sed -i "s|$termoAntigo|$termoNovo|g" "$arquivo"
        echo "[MODIFICADO] $arquivo"
    end

    echo "[OK] Substituição profunda concluída com sucesso!"

# =============================================================
# @How_To_Use
# Use_1: replaceTerms ANTIGO NOVO      # Substitui de forma segura após confirmação
# ===========================================================
end

# ==============================================================================
# @README_FILE
#
# @IMPORTANTE_PROFILE: 
# - Funções no topo, operadores estritos.
# - Versão blindada com confirmação prévia e exclusão de pastas críticas (.git).
# ==============================================================================
