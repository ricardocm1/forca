//
//  JogoDaForca.swift
//  Forca
//
//  Created by Ricardo Carra Marsilio on 08/10/20.
//

import Foundation

class JogoDaForca {
    internal init(palavra: String, dica: String) {
        self.palavra = palavra.comparavel
        self.dica = dica
        self.palavraMascarada = palavra.map { _ in "_" }.joined()
    }
    
    let maximoDeErros: Int = 5
    
    let palavra: String
    let dica: String
    private(set) var palavraMascarada: String
    private(set) var tentativasAnteriores: [String] = []
    private(set) var erros: Int = 0 {
        didSet {
            if erros > maximoDeErros {
                derrota = true
            }
        }
    }
    private(set) var derrota: Bool = false
    private(set) var vitoria: Bool = false
    
    
    func tentativa(letra: String) {
        guard let letraInformada = letra.first?.comparavel else {
            return
        }
        
        if tentativasAnteriores.contains(letraInformada) {
            // validar letra repetida
            return
        }
        
        tentativasAnteriores.append(letraInformada)
        
        guard palavra.contains(letraInformada) else {
            erros += 1
            
            return
        }
        
        palavraMascarada = troca(letraInformada, na: palavraMascarada, com: palavra)
        
        if palavra == palavraMascarada {
            vitoria = true
        }
    }
}
