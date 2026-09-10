# @file: testShell.fish
# @mission: Exibição de mensagem de confirmação para validação do ambiente Fish Shell.
#
# @desc:
# Função de teste isolada para o Fish Shell. Utilizada para verificar a segregação
# de ambiente e a leitura correta dos scripts .fish na pasta de funções.
#
# @porque_funcionou:
# O Fish Shell possui um mecanismo nativo de carregamento sob demanda (autoload)
# que mapeia a pasta de funções. Ao registrar a função nesse caminho,
# o Fish passa a reconhecer o comando automaticamente pelo nome exato do arquivo (testShell.fish).


function testShell --description "Exibe mensagem de teste para o ambiente Fish"
    set_color ff8800 --bold
    echo "[ok] LOAD FUNCTIONS >> {{ FISH }} SUCESS !!!"
    set_color normal
    
# =============================================================
# @Como_Usar
# Uso_1: testShell
# ===========================================================
end

# ==============================================================================
# @README_Plugin
# - O que está incluído: Função testShell para validação do ambiente Fish.
# - Comportamento: Exibe uma mensagem colorida em laranja negrito informando o sucesso do carregamento.
# - Como Usar: testShell
# - Tags: #contexto #wfunc #automacao #fish
# ==============================================================================