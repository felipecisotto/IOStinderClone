//
//  CombineViewController.swift
//  TinderClone
//
//  Created by Felipe Cisotto on 05/04/20.
//  Copyright © 2020 Felipe Cisotto. All rights reserved.
//

import UIKit

class CombineVC:UIViewController {
    var usuarios: [Usuario] = []
    override func viewDidLoad() {
        view.backgroundColor = UIColor.systemGroupedBackground
        self.buscaUsuarios()
    }
    func buscaUsuarios () {
        self.usuarios =  UsuarioService.shared.buscaUsuarios()
        self.adicionarCards()
    }
}
extension CombineVC{
    func adicionarCards() {
        for usuario in self.usuarios {
            let card = CombinaCardView()
            card.frame = CGRect(x: 0, y: 0, width: view.bounds.width-32, height: view.bounds.height * 0.7)
            card.center = view.center
            card.usuario = usuario
            card.tag = usuario.id
            
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(handleCard))
            view.addSubview(card)
            card.addGestureRecognizer(gesture)
            view.insertSubview(card, at: 0)
        }
        
    }
}
extension CombineVC{
    @objc func handleCard(gesture: UIPanGestureRecognizer){
        if let card = gesture.view as? CombinaCardView{
            let point = gesture.translation(in: view)
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            let rotateAngle = point.x / view.bounds.width * 0.4
            if point.x > 0 {
                card.likeImageView.alpha = rotateAngle * 5
                card.dislikeImageView.alpha = 0
            }else {
                card.likeImageView.alpha = 0
                card.dislikeImageView.alpha = rotateAngle * -5
            }
            card.transform = CGAffineTransform(rotationAngle: rotateAngle)
            if gesture.state == .ended {
                UIView.animate(withDuration: 0.2){
                    card.transform = .identity
                    card.center = self.view.center
                    card.likeImageView.alpha = 0
                    card.dislikeImageView.alpha = 0
                }
                
            }
        }
        
    }
    
}
