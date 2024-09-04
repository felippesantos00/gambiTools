#!/bin/bash
print_log(){
    local msg=$1
    output=$(echo "$(date "+%F %T.%3N") - ${msg}")
    echo "$output" >> gambiTools_output.log

}
# Carregue os scripts e verifique erros
for script in $(ls ./gambiarras/*.sh); do
    if [[ -f "$script" ]]; then
        print_log "Carregando $script..."
        source "$script" || { print_log "Falha ao carregar $script"; exit 1; }
    else
        print_log "Arquivo $script não encontrado."
    fi
done

# Processamento dos argumentos
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --fdate) 
            fdate="$2"; 
            shift ;;  # Armazena o próximo valor em fdate
        --date-min) 
            date_min_1="$2"; 
            date_min_2="$3"; 
            shift 2 ;;  # Armazena o próximo valor em date_min
        --date-sec) 
            date_sec_1="$2"; 
            date_sec_2="$3"; 
            shift 2 ;;  # Armazena o próximo valor em date_sec
        --date-day) 
            date_day_1="$2"; 
            date_day_2="$3"; 
            shift 2 ;;  # Armazena o próximo valor em date_day
        *) 
            print_log "Unknown parameter passed: $1"; 
            exit 1 ;;  # Argumento desconhecido
    esac
    shift
done

# Verifica se a variável fdate foi definida

if [ -n "$fdate" ];then
    formatar_datas_para_iso_8601 $fdate
elif [[ -n "$date_min_1" && -n "$date_min_2" ]];then
    generate_timeline "$date_min_1" 60 "$date_min_2"
elif [ -n "$date_sec_1" && -n "$date_sec_2" ];then
    generate_timeline "$date_sec_1" 1 "$date_sec_2"
elif [ -n "$date_day_1" && -n "$date_day_2" ];then
    generate_timeline "$date_day_1" 86400 "$date_day_2"
fi