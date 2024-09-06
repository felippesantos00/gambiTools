#!/bin/bash

# Verifica se um arquivo existe e registra o resultado
verificar_arquivo_existe() {
    local arquivo="$1"
    if [[ -e $arquivo ]]; then
        registrar_log "Arquivo existe: $arquivo"
        return 0
    else
        registrar_log "Arquivo não existe: $arquivo"
        return 1
    fi
}

# Verifica se um diretório existe e registra o resultado
verificar_diretorio_existe() {
    local diretorio="$1"
    if [[ -d $diretorio ]]; then
        registrar_log "Diretório existe: $diretorio"
        return 0
    else
        registrar_log "Diretório não existe: $diretorio"
        return 1
    fi
}

# Registra uma mensagem com data e hora
registrar_log() {
    local mensagem="$1"
    local diretorio_logs="C:\\xampp\\htdocs\\gambiTools\\logs"
    local arquivo_log="${diretorio_logs}\\gambiTools_output.log"
    local timestamp=$(date "+%F %T.%3N")
    echo "$timestamp - $mensagem" >> "$arquivo_log"
    rotacionar_logs "$diretorio_logs" "10k"
}

# Rotaciona os arquivos de log que excedem um determinado tamanho
rotacionar_logs() {
    local diretorio_logs="$1"
    local tamanho="$2"
    local diretorio_atual=$(pwd)
    
    if [[ -d $diretorio_logs ]]; then
        registrar_log "Diretório de logs existe: $diretorio_logs"
    else
        registrar_log "Criando diretório de logs: $diretorio_logs"
        mkdir -p "$diretorio_logs"
    fi

    cd "$diretorio_logs" || return
    find . -type f -name "*.log" -size +"$tamanho" -exec mv {} {}.$(date "+%Y%m%d%H%M%S") \;
    if [[ $? -eq 0 ]]; then
        registrar_log "Arquivos de log rotacionados no diretório: $diretorio_logs"
        cd "$diretorio_atual" || return
        return 0
    else
        registrar_log "Nenhum arquivo de log precisa ser rotacionado no diretório: $diretorio_logs"
        cd "$diretorio_atual" || return
        return 1
    fi
}

# Busca uma palavra em arquivos de log
buscar_palavra_em_log() {
    local arquivo="$1"
    local palavra="$2"
    registrar_log "Buscando palavra: $palavra no arquivo: $arquivo"
    zgrep "$palavra" "$arquivo"*
    if [[ $? -eq 0 ]]; then
        registrar_log "Palavra encontrada: $palavra"
        return 0
    else
        registrar_log "Palavra não encontrada: $palavra"
        return 1
    fi
}

# Cria um backup de um arquivo e comprime com base no sistema operacional
criar_backup_arquivo() {
    local arquivo="$1"
    local diretorio_backup="../dados_ficticios"
    local sistema=$(identificar_sistema_operacional)
    
    registrar_log "Sistema operacional detectado: $sistema"
    registrar_log "Compactando arquivo: $arquivo"

    case "$sistema" in
        Linux)
            find ./ -type f -name "${arquivo}*" -exec zip -1 "${arquivo%.*}.zip" {} \;
            ;;
        MINGW64_NT-10.0-19045)
            find ./ -type f -name "${arquivo}*" -exec zip a "${arquivo%.*}.zip" {} \;
            ;;
        *)
            registrar_log "Sistema operacional não suportado: $sistema"
            return 1
            ;;
    esac
}

# Obtém o nome do sistema operacional
identificar_sistema_operacional() {
    local nome_sistema=$(uname -s)
    registrar_log "Identificando sistema operacional: $nome_sistema"
    echo "$nome_sistema"
}
