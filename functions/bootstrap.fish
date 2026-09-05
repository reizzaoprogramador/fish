# ==============================================================================
# @file: bootstrap.fish
# @mission: Clonar dotfiles se necessário, instalar pacotes apt/curl de forma declarativa e executar as funções finais definidas na variável EXECUTE_FUNCTION_FINAL_BOOSTRAP.
# ==============================================================================

function bootstrap --description "Clona dotfiles, instala dependencias declaradas e inicializa o ambiente modular"
    # 0. Garante que o repositório dotfiles existe (clona se necessário)
    set -l target_dotfiles "$HOME/www/dotfiles"
    if not test -d "$target_dotfiles"
        set_color blue --bold
        echo "[BOOTSTRAP] Clonando repositório dotfiles do GitHub..."
        set_color normal
        mkdir -p "$HOME/www"
        if type -q git
            git clone https://github.com/reizzz/dotfiles.git "$target_dotfiles"
        else
            echo "[ERRO] O comando 'git' não está instalado. Instale-o primeiro."
            return 1
        end
    end

    set -l DEPS_DIR "$BOOTSTRAP_DEPS/installs_deb"

    if not test -d $DEPS_DIR
        set_color red --bold
        echo "[ERRO] Diretorio de pacotes nao encontrado em $DEPS_DIR"
        set_color normal
        return 1
    end

    set_color blue --bold
    echo "[BOOTSTRAP] Atualizando listas do APT..."
    set_color normal
    sudo apt update -y

    for file in $DEPS_DIR/*
        set -l filename (basename $file)

        # Pula explicitamente arquivos que nao sao listas de pacotes APT
        if test "$filename" = "README.md"; or test "$filename" = "README"; or string match -q "*.sh" $filename
            continue
        end

        if test -f $file
            set_color yellow --bold
            echo "[BOOTSTRAP] Lendo pacotes de: $filename"
            set_color normal

            for pkg in (cat $file)
                if string match -q "#*" $pkg; or test -z "$pkg"
                    continue
                end
                set_color green --bold
                echo " [APT] Instalando: $pkg"
                set_color normal
                sudo apt install -y $pkg
            end
        end
    end

    # Executa a instalação via cURL chamando o script corretamente a partir do diretório de scripts ($SHELLS)
    if test -x "$SHELLS/install_by_curl.sh"
        set_color blue --bold
        echo "[BOOTSTRAP] Executando instalações via cURL..."
        set_color normal
        bash "$SHELLS/install_by_curl.sh"
    end

    set_color green --bold
    echo "[OK] AMBIENTE FISH: Bootstrap de dependencias concluido com sucesso !!!"
    set_color normal

    # ==========================================================================
    # EXECUTAR FUNCOES FINAIS CONFIGURADAS NA VARIAVEL
    # ==========================================================================
    if set -q EXECUTE_FUNCTION_FINAL_BOOSTRAP
        set_color blue --bold
        echo "[BOOTSTRAP] Executando rotinas finais do sistema modular..."
        set_color normal

        # Trata a string removendo eventuais vírgulas e separa em array
        set -l func_list (string replace -a ',' ' ' "$EXECUTE_FUNCTION_FINAL_BOOSTRAP")

        for func_name in $func_list
            set -l clean_func (string trim "$func_name")
            if test -n "$clean_func"
                if functions -q "$clean_func"
                    echo "[RUN] Executando: $clean_func"
                    eval "$clean_func"
                else
                    echo "[AVISO] Função '$clean_func' definida em EXECUTE_FUNCTION_FINAL_BOOSTRAP não foi encontrada."
                end
            end
        end
    end

# =============================================================
# @Como_Usar
# Use_1: bootstrap
# =============================================================
end

# ==============================================================================
# @README
# ------------------------------------------------------------------------------
# @ATENCAO: 
    # - Sempre use este padrao em todos files,
    # - antes de mudancas leia este #@README, não faça mudancas sem avisar, nem marretacoes sem a autorização do proprietário.

# @objetivo_file: clonar dotfiles, instalar dependencias debian/curl e disparar dinamicamente as funções listadas em $EXECUTE_FUNCTION_FINAL_BOOSTRAP
# @requisitos_essenciais: fish shell, permissao sudo, git, variável EXECUTE_FUNCTION_FINAL_BOOSTRAP definida nos arquivos RC
# @regras: manter declaracao de funcoes no topo
# @erros_ocorridos: chamadas hardcoded limitavam a flexibilidade de inclusão de novas funções pós-bootstrap
# @como_resolveu: loop dinâmico avaliando a string/array da variável EXECUTE_FUNCTION_FINAL_BOOSTRAP
# @tags: #bootstrap #apt #fish #wshells #automation
# ==============================================================================