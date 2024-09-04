#parametros start_date days hours minutes
# format_date=$(echo "$1" | sed -r 's/(-|:)/ /g')
# seconds=$2
# qtd_lines=$3
# start_date=$format_date

generate_timeline() {
    # Formata a data de entrada no formato esperado pelo mktime
    local format_date=$(echo "$1" | sed -r 's/[-:]/ /g')
    local seconds=$2
    local qtd_lines=$3
    
    # Inicia o AWK
    echo "${format_date}" | awk -v qtd_lines="${qtd_lines}" -v seconds="${seconds}" -v start_date="${format_date}" 'BEGIN{
       
        lines=0
        start_epoch = mktime(start_date)
    }{
        # Loop para gerar os timestamps
        while(lines < qtd_lines){
            print strftime("%F %T", start_epoch + (lines * seconds))
            lines++
        }
    }'
}
# case $2 in
#     min|minute|minutes|m) 
#     generate_timeline "$1" 60 "$3"
# ;;
#     sec|seconds|second|s) 
#         generate_timeline "$1" 1 "$3"
# ;;
#     day|days|d) 
#         generate_timeline "$1" 86400 "$3"
# ;;
#     *)  
#         echo "Opção inválida! Use 'min|minute|minutes|m', 'sec|seconds|second|s' ou 'day|days|d'."
#         echo "Exemplo de comando: ./gerador_timeline.sh "2024-09-03 20:30:00" sec 10"
#         exit 1
# ;;
# esac