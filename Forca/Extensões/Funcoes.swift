//
//  Funcoes.swift
//  Forca
//
//  Created by Ricardo Carra Marsilio on 08/10/20.
//

import Foundation

func troca(_ letraInformada :String, na mascara: String, com original: String) -> String {
    let letra = Character(letraInformada)
    var resultado = mascara
    
    for indice in original.indices {
        if original[indice] == letra {
            resultado.remove(at: indice)
            resultado.insert(letra, at: indice)
        }
    }
    
    return resultado
}
