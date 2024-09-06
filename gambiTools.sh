#!/bin/bash

# Função para imprimir logs
print_log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

# Carregue os scripts e verifique erros
for script in ./gambiarras/*.sh; do
    if [[ -f "$script" ]]; then
        print_log "Carregando $script..."
        source "$script" || { print_log "Falha ao carregar $script"; exit 1; }
    else
        print_log "Arquivo $script não encontrado."
    fi
done

# Verifica se o primeiro argumento é fornecido
if [[ -z "$1" ]]; then
    print_log "Nenhum comando fornecido."
    echo "Uso: $0 [opção] [argumentos]"
    echo "Opções disponíveis:"
    echo "  --fdate [FILENAME]   Formata datas de um arquivo para o padrão ISO 8601"
    echo "  --date-sec [DATA INICIAL] [QTD LINHAS]   Gera uma linha do tempo com intervalos de segundos"
    echo "  --date-min [DATA INICIAL] [QTD LINHAS]   Gera uma linha do tempo com intervalos de minutos"
    echo "  --date-day [DATA INICIAL] [QTD LINHAS]   Gera uma linha do tempo com intervalos de dias"
    exit 1
fi

comando=$1
code=1

# Processamento dos argumentos
shift
while [[ "$#" -gt 0 ]]; do
    case $comando in
        --fdate)
            filename="$1"
            if [[ -e "$filename" ]]; then
                formatar_datas_para_iso_8601 "$filename"
                code=$?
            else
                print_log "Arquivo não encontrado: $filename"
                echo "Arquivo não existe ou inválido!"
            fi
            echo "Exit ${code}"
            exit $code
            ;;
        --date-sec)
            start_date="$1"
            qt_lines="$2"
            if [[ -n "$start_date" && -n "$qt_lines" ]]; then
                generate_timeline "$start_date" 1 "$qt_lines"
                code=$?
            else
                print_log "Parâmetros inválidos para --date-sec"
                echo "Use: --date-sec [DATA INICIAL] [QTD LINHAS]"
            fi
            echo "Exit ${code}"
            exit $code
            ;;
        --date-min)
            start_date="$1"
            qt_lines="$2"
            if [[ -n "$start_date" && -n "$qt_lines" ]]; then
                generate_timeline "$start_date" 60 "$qt_lines"
                code=$?
            else
                print_log "Parâmetros inválidos para --date-min"
                echo "Use: --date-min [DATA INICIAL] [QTD LINHAS]"
            fi
            echo "Exit ${code}"
            exit $code
            ;;
        --date-day)
            start_date="$1"
            qt_lines="$2"
            if [[ -n "$start_date" && -n "$qt_lines" ]]; then
                generate_timeline "$start_date" 86400 "$qt_lines"
                code=$?
            else
                print_log "Parâmetros inválidos para --date-day"
                echo "Use: --date-day [DATA INICIAL] [QTD LINHAS]"
            fi
            echo "Exit ${code}"
            exit $code
            ;;
        *)
            print_log "Opção desconhecida: $comando"
            echo "Opção $comando inválida! Use:"
            echo "  --fdate [FILENAME]   Formata datas de um arquivo para o padrão ISO 8601"
            echo "  --date-sec [DATA INICIAL] [QTD LINHAS]   Gera uma linha do tempo com intervalos de segundos"
            echo "  --date-min [DATA INICIAL] [QTD LINHAS]   Gera uma linha do tempo com intervalos de minutos"
            echo "  --date-day [DATA INICIAL] [QTD LINHAS]   Gera uma linha do tempo com intervalos de dias"
            exit 1
            ;;
    esac
    shift
done
