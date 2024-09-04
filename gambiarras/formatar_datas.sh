formatar_datas_para_iso_8601(){
    local FILE=$1
    cat $FILE | awk  'BEGIN{
        OFS=";"
        FS="[,|;]"
    }{
        
        if(match($1,/(20[0-9][0-9])[\/\.\-_ ]?(0[0-9]|1[0-2])[\/\.\-_ ]?(0[1-9]|1[0-9]|2[0-9]|3[0-1])[T\-_ ]?([0-1][0-9]|2[0-3])?:?([0-5][0-9])?:?([0-5][0-9])?/,data)){
            Y=data[1]
            D=data[2]
            M=data[3]
            h=(data[4] == "" ? "00" : data[4])
            m=(data[5] == "" ? "00" : data[5])
            s=(data[6] == "" ? "00" : data[6])
        }else if(match($1,/(0[0-9]|1[0-2])[\/\.\-_ ]?(0[1-9]|1[0-9]|2[0-9]|3[0-1])[\/\.\-_ ]?(20[0-9][0-9])[T\-_ ]?([0-1][0-9]|2[0-3])?:?([0-5][0-9])?:?([0-5][0-9])?/,data)){
            Y=data[3]
            D=data[2]
            M=data[1]
            h=(data[4] == "" ? "00" : data[4])
            m=(data[5] == "" ? "00" : data[5])
            s=(data[6] == "" ? "00" : data[6])
        }else{
            next
        }
        $1=strftime("%FT%T",mktime(Y" "M" "D" "h" "m" "s))
        print $0
    }'
}
# if [[ -e $1 ]];then
#     formatar_datas_para_iso_8601 $1
# else
#     echo "Arquivo Nao Existe!"
#     echo "Exemplo de comando: ./formatar_datas.sh timestamp_variations_with_fictitious_values.csv"
#     exit 1
# fi