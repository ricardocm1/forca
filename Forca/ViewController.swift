//
//  ViewController.swift
//  Forca
//
//  Created by Ricardo Carra Marsilio on 06/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var chutesLabel: UILabel!
    @IBOutlet weak var letraTextField: UITextField!
    @IBOutlet weak var bonecoImageView: UIImageView!
    @IBOutlet weak var dicaLabel: UILabel!
    @IBOutlet weak var palavraMascaradaLabel: UILabel!
    
    var indice: Int = 1
    var jogo: JogoDaForca = JogoDaForca.aleatorio()
    
    @IBAction func toqueBotaoRecomecar(_ sender: Any) {
        novoJogo()
//        indice += 1
//
//        UIView.transition(
//            with: bonecoImageView,
//            duration: 0.1,
//            options: .transitionCrossDissolve,
//            animations: {
//                self.bonecoImageView.image = UIImage(named: "bonecao_fase_\(self.indice)")
//            },
//            completion: nil)
//
//        if indice == 5 {
//            indice = 0
//        }
    }
    
    @IBAction func toqueTecladoConcluido(_ sender: Any) {
//        if let texto = letraTextField.text, let chutesAtuais = chutesLabel.attributedText {
//            var textoAtual = NSMutableAttributedString(attributedString: chutesAtuais)
//            textoAtual.append(texto.espacada)
//
//            chutesLabel.attributedText = textoAtual
//        }
        
        if let texto = letraTextField.text {
            jogo.tentativa(letra: texto)
            atualizarTela()
        }
        
        dispensarTeclado()
    }
    
    @IBAction func textoAlterado(_ sender: Any) {
        letraTextField.text = letraTextField.text?.last?.uppercased()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        atualizarTela()
    }
}

extension ViewController {
    private func atualizarTela() {
        dicaLabel.text = "A dica é: \(jogo.dica)"
        palavraMascaradaLabel.attributedText = jogo.palavraMascarada.espacada
        chutesLabel.attributedText = formatarChutesAnteriores()
        letraTextField.text = ""
        
        atualizarImagem()
        
        if jogo.derrota {
            avisarPerdedor()
        } else if jogo.vitoria {
            avisarVencedor()
        }
    }
    
    private func formatarChutesAnteriores() -> NSAttributedString {
        jogo.tentativasAnteriores.reduce(NSMutableAttributedString()) { (texto, letra) in
            if jogo.palavra.contains(letra) {
                texto.append(letra.corVerde)
            } else {
                texto.append(letra.corVermelho)
            }
            
            return texto
        }.espacada
     }
    
    private func avisarPerdedor() {
        let alerta = UIAlertController(title: "Que pena, você errou!", message: "Pensa mais, cavalo", preferredStyle: .alert)
        alerta.addAction(acao)
        present(alerta, animated: true, completion: nil)
    }
    
    private func avisarVencedor() {
        let alerta = UIAlertController(title: "Maoe!", message: "Parabéns, você ganhou!", preferredStyle: .alert)
        alerta.addAction(acao)
        present(alerta, animated: true, completion: nil)
    }
    
    var acao: UIAlertAction { UIAlertAction(title: "Jogar novamente", style: .default) { _ in
            self.novoJogo()
        }
    }
    
    private func novoJogo() {
        jogo = JogoDaForca.aleatorio()
        atualizarTela()
    }
    
    private func atualizarImagem() {
        let image: UIImage?
        
        if jogo.derrota {
            image = UIImage(named: "bonecao_completo_e_mortinho")
        } else if jogo.erros == 0 {
            image = nil
        } else {
            image = UIImage(named: "bonecao_fase_\(jogo.erros)")
        }
        
        UIView.transition(
            with: bonecoImageView,
            duration: 0.1,
            options: .transitionCrossDissolve,
            animations: {
                self.bonecoImageView.image = image
            },
            completion: nil)
    }
}

let palavras = [
    "abelha": "inseto",
    "formiga": "inseto",
    "macaco": "animal",
    "cabra": "animal"
]

extension JogoDaForca {
    class func aleatorio() -> JogoDaForca {
        guard let item = palavras.randomElement()
        else {
            return JogoDaForca(palavra: "DESNATADO", dica: "MICROFONE")
        }
        
        return JogoDaForca(palavra: item.key, dica: item.value)
    }
}

