# @file: linkHome.fish
# @mission: Criar link simbolico na $HOME para o arquivo ou diretorio atual/especificado.
#
# @desc:
# Pega o item passado por parâmetro ou o diretorio atual (pwd) e faz o link
# simbolico direto para o $HOME do usuario no Fish Shell.
#
# @porque_funcionou:
# Resolver o caminho nativamente e disparar o 'ln -sf' garante que o ponteiro
# na Home seja atualizado instantaneamente no Fish sem quebra de contexto.

function linkHome --description "Cria link simbolico na $HOME para o local atual ou argumento"
    set -l target $argv[1]
    if test -z "$target"
        set target (pwd)
    end

    if not test -e $target
        set_color red --bold
        echo "[ERRO] O alvo $target nao existe!"
        set_color normal
        return 1
    end

    set -l name (basename $target)
    ln -sf $target $HOME/$name
    set_color green --bold
    echo "[OK] AMBIENTE FISH: Link criado $target -> $HOME/$name"
    set_color normal
end

# =============================================================
# @Como_Usar
# Uso_1: cd /caminho/da/pasta; e linkHome
# Uso_2: linkHome /caminho/do/arquivo_ou_pasta
# =============================================================
