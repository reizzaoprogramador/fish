# @file: ttt.fish
# @mission: Exibição de mensagem de confirmação para validação do ambiente Fish Shell.
#
# @desc:
# Função de teste isolada para o Fish Shell. Utilizada para verificar a segregação
# de ambiente e a leitura correta dos scripts .fish na pasta de funções.
#
# @porque_funcionou:
# O Fish Shell possui um mecanismo nativo de carregamento sob demanda (autoload)
# que mapeia a pasta de funções. Ao registrar a função nesse caminho,
# o Fish passa a reconhecer o comando automaticamente pelo nome exato do arquivo (ttt.fish).


function ttt --description "Exibe mensagem de teste para o ambiente Fish"
    set_color b8ae5a
    echo "[fish] load function  >> {{    FISH    }}  >> [ok] !!!"
    set_color normal
    
# =============================================================
# @Como_Usar
# Uso_1: ttt
# ===========================================================
end

# ==============================================================================
# @README_Plugin
# - O que está incluído: Função ttt para validação do ambiente Fish.
# - Comportamento: Exibe uma mensagem colorida em laranja negrito informando o sucesso do carregamento.
# - Como Usar: ttt
# - Tags: #contexto #wfunc #automacao #fish
# ==============================================================================