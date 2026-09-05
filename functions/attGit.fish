# @file: attGit.fish
# @mission: Iniciar o ssh-agent e carregar as chaves SSH pessoais de ~/www/wdotfiles/.ssh.
#
# @desc:
# Inicializa a sessao do ssh-agent no Fish Shell e adiciona as chaves privadas encontradas em
# ~/www/wdotfiles/.ssh, garantindo a conexao SSH autenticada com o GitHub.
#
# @porque_funcionou:
# No Fish Shell, ao inves de 'eval', o comando 'ssh-agent -c' e interpretado nativamente
# garantindo que o socket de autenticacao seja exportado para a sessao do usuario.

function attGit --description "Carrega as chaves SSH no agente de autenticacao para o Git"
    set -l SSH_DIR "$HOME/www/wdotfiles/.ssh"

    if not test -d $SSH_DIR
        set SSH_DIR "$HOME/.ssh"
    end

    set_color blue --bold
    echo "[SSH] Verificando agente de chaves SSH..."
    set_color normal

    if test -z "$SSH_AUTH_SOCK"
        eval (ssh-agent -c) >/dev/null
    end

    set -l keys_added 0
    for key in $SSH_DIR/id_*
        if not string match -q "*.pub" $key; and test -f $key
            chmod 600 $key
            ssh-add $key >/dev/null 2>&1
            set_color green --bold
            echo "[OK] Chave carregada: "(basename $key)
            set_color normal
            set keys_added (math $keys_added + 1)
        end
    end

    if test $keys_added -eq 0
        set_color yellow --bold
        echo "[AVISO] Nenhuma chave privada encontrada em $SSH_DIR!"
        set_color normal
        return 1
    end

    set_color green --bold
    echo "[OK] AMBIENTE FISH: Credenciais SSH carregadas e prontas para o Git !!!"
    set_color normal
end

# =============================================================
# @Como_Usar
# Uso_1: attGit
# =============================================================
