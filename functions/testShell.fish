# @file: testShell.fish
# @mission: Exibição de mensagem de confirmação para validação do ambiente Fish Shell.
#
# @desc:
# Função de teste isolada para o Fish Shell. Utilizada para verificar a segregação
# de ambiente e a leitura correta dos scripts .fish na pasta ~/www/wfunc.
#
# @porque_funcionou:
# O Fish Shell possui um mecanismo nativo de carregamento sob demanda (autoload)
# que mapeia a pasta ~/.config/fish/functions. Ao registrar a função nesse caminho
# e associar o $fish_function_path à pasta ~/www/wfunc, o Fish passa a reconhecer
# o comando automaticamente pelo nome exato do arquivo (testShell.fish), eliminando
# falhas de expansão de wildcards em loops de inicialização e garantindo o isolamento
# de scripts .sh no ambiente Fish.


function testShell --description "Exibe mensagem de teste para o ambiente Fish"
    echo "[OK] Ambiente Shell FISH [ok] !"
end

# =============================================================
# @Como_Usar
# Uso_1: testShell
# =============================================================
