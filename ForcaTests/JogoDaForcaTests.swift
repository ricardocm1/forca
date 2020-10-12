//
//  JogoDaForcaTests.swift
//  ForcaTests
//
//  Created by Ricardo Carra Marsilio on 10/10/20.
//

import XCTest
import Nimble
import Quick

@testable import Forca

class JogoDaForcaTests: QuickSpec {
    override func spec() {
        var jogoDaForca: JogoDaForca!
        
        beforeEach {
            jogoDaForca = JogoDaForca(palavra: "JACARÉ", dica: "ANIMAL")
        }
        
        describe("ao jogar normalmente") {
            context("ao escrever uma letra correta") {
                it("que não tenha nenhum erro") {
                    jogoDaForca.tentativa(letra: "É")
                    expect(jogoDaForca.erros).to(equal(.zero))
                    expect(jogoDaForca.palavraMascarada).to(equal("_____E"))
                }
            }
            
            context("ao escrever uma letra errada") {
                it("deverá ter apenas um erro") {
                    jogoDaForca.tentativa(letra: "X")
                    expect(jogoDaForca.erros).to(equal(1))
                }
            }
            
            context("ao repetir um erro") {
                it("deverá ter apenas um erro") {
                    jogoDaForca.tentativa(letra: "X")
                    jogoDaForca.tentativa(letra: "X")
                    expect(jogoDaForca.erros).to(equal(1))
                }
            }
            
            context("errando tudo") {
                it("deverá perder o jogo") {
                    let tentativas = ["I", "X", "Q", "P", "O"]
                    
                    for tentativa in tentativas {
                        jogoDaForca.tentativa(letra: tentativa)
                    }
                    
                    expect(jogoDaForca.derrota).to(beFalse())
                    
                    jogoDaForca.tentativa(letra: "Z")
                    expect(jogoDaForca.derrota).to(beTrue())
                }
            }
            
            context("com uma letra correta repetida na palavra") {
                it("deverá atualizar dois espaços") {
                    jogoDaForca.tentativa(letra: "A")
                    
                    expect(jogoDaForca.palavraMascarada).to(equal("_A_A__"))
                }
            }
            
            context("ao digitar uma letra correta repetida") {
                it("não deverá gerar um erro") {
                    jogoDaForca.tentativa(letra: "A")
                    jogoDaForca.tentativa(letra: "A")
                    
                    expect(jogoDaForca.erros).to(equal(.zero))
                    expect(jogoDaForca.palavraMascarada).to(equal("_A_A__"))
                }
            }
            
            context("com todas as letras corretas") {
                it("deverá vencer o jogo") {
                    ["J", "A", "E", "R"].forEach(jogoDaForca.tentativa)
                    
                    expect(jogoDaForca.derrota).to(beFalse())
                    expect(jogoDaForca.vitoria).to(beFalse())
                    
                    ["I", "X", "Q", "P", "Z", "Ç"].forEach(jogoDaForca.tentativa)
                    
                    expect(jogoDaForca.derrota).to(beFalse())
                    expect(jogoDaForca.vitoria).to(beTrue())
                }
            }
        }
    }
}
