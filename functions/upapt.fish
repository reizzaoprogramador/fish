# ==============================================================================
# @file: upapt.fish
# @mission: Realizar limpeza geral do sistema (APT e otimizacao do Git)
# ==============================================================================
function upapt --description "Limpa cache do apt, remove pacotes orfaos e faz o git gc"
    set_color blue --bold
    echo "[INFO] Iniciando limpeza e otimizacao do sistema..."
    set_color normal

    # 1. Limpeza do APT e pacotes órfãos
    sudo apt clean && sudo apt autoremove -y
    and begin
        set_color green --bold
        echo "[OK] Limpeza do APT concluida com sucesso."
        set_color normal
    end
    or begin
        set_color red --bold
        echo "[ERRO] Falha durante a limpeza do APT."
        set_color normal
        return 1
    end

    # 2. Otimização do repositório Git atual (se houver .git)
    if test -d .git
        set_color yellow --bold
        echo "[INFO] Otimizando repositorio Git local..."
        set_color normal
        git gc --prune=now
        and begin
            set_color green --bold
            echo "[OK] Repositorio Git otimizado."
            set_color normal
        end
    end

    set_color green --bold
    echo "[OK] Sistema limpo e otimizado com sucesso!"
    set_color normal
end

# ==============================================================================
# @README_Plugin
# - O que está incluído: Função upapt para Fish Shell para limpeza de pacotes e garbage collection do Git.
# - Comportamento: Roda `sudo apt clean && sudo apt autoremove -y` seguido de `git gc --prune=now` caso o diretório atual seja um repositório git.
# - Como usar: `upapt`
# ==============================================================================