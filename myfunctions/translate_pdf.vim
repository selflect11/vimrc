function! ExpurgateText (text)
    let expurgated_text = a:text

    " êôíóáéíàãç
    let translate_dict = {"Í":"ê", "Ù":"ô", "Û":"ó", "·":"á", "È":"é", "Ì":"í", "‡":"à", "„":"ã", "Á":"ç"}
    for [wrong, right] in items(translate_dict)
        let expurgated_text = substitute(expurgated_text, wrong, right, 'g')
    endfor

    return expurgated_text
endfunction
