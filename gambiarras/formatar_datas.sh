formatar_datas_para_iso_8601() {
    local file="$1"

    awk -F '[,|;]' '
    BEGIN {
        OFS=";"
    }
    {
        # Regular expression para formatos de data
        if (match($1, /(20[0-9]{2})[\/\.\-_ ]?(0[0-9]|1[0-2])[\/\.\-_ ]?(0[1-9]|[12][0-9]|3[01])[T\-_ ]?([01][0-9]|2[0-3])?:?([0-5][0-9])?:?([0-5][0-9])?/, date_parts)) {
            year = date_parts[1]
            month = date_parts[2]
            day = date_parts[3]
            hour = date_parts[4] ? date_parts[4] : "00"
            minute = date_parts[5] ? date_parts[5] : "00"
            second = date_parts[6] ? date_parts[6] : "00"
        } else if (match($1, /(0[0-9]|1[0-2])[\/\.\-_ ]?(0[1-9]|[12][0-9]|3[01])[\/\.\-_ ]?(20[0-9]{2})[T\-_ ]?([01][0-9]|2[0-3])?:?([0-5][0-9])?:?([0-5][0-9])?/, date_parts)) {
            year = date_parts[3]
            month = date_parts[1]
            day = date_parts[2]
            hour = date_parts[4] ? date_parts[4] : "00"
            minute = date_parts[5] ? date_parts[5] : "00"
            second = date_parts[6] ? date_parts[6] : "00"
        } else {
            next
        }
        
        # Formata a data para o padrão ISO 8601
        $1 = strftime("%FT%T", mktime(year " " month " " day " " hour " " minute " " second))
        print $0
    }' "$file"
}
