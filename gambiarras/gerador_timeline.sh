generate_timeline() {
    local format_date="$1"
    local seconds="$2"
    local qtd_lines="$3"

    # Converte a data para o formato esperado pelo mktime
    local formatted_date=$(echo "$format_date" | sed -r 's/[-:]/ /g')

    # Gera a linha do tempo usando AWK
    awk -v start_date="$formatted_date" -v interval="$seconds" -v count="$qtd_lines" '
    BEGIN {
        start_epoch = mktime(start_date)
        for (i = 0; i < count; i++) {
            print strftime("%F %T", start_epoch + (i * interval))
        }
    }'
}
