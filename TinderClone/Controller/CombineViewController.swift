//
//  CombineViewController.swift
//  TinderClone
//
//  Created by Felipe Cisotto on 05/04/20.
//  Copyright © 2020 Felipe Cisotto. All rights reserved.
//

import UIKit

class CombineVC:UIViewController {
    enum acao  {
        case like
        case superlike
        case dislike
    }
    var usuarios: [Usuario] = []
    
    var perfilButton: UIButton = .iconMenu(named: "icone-perfil")
    var chatButton: UIButton = .iconMenu(named: "icone-chat")
    var logoButton: UIButton = .iconMenu(named: "icone-logo")
    
    var desLikeButton: UIButton = .iconFooter(named: "icone-dislike")
    var likeButton: UIButton = .iconFooter(named: "icone-like")
    var superLikeButton: UIButton = .iconFooter(named: "icone-superlike")
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.systemGroupedBackground
        navigationController?.navigationBar.isHidden = true
        
        let loading = Loading(frame: view.frame)
        view.insertSubview(loading, at: 0)
        
        self.adicionaHeader()
        self.adicionarFooter() 
        self.buscaUsuarios()
       
    }
    func buscaUsuarios () {
        UsuarioService.shared.buscaUsuarios{(usuarios,err) in
            if let usuarios = usuarios{
                DispatchQueue.main.async {
                    self.usuarios =  usuarios
                    self.adicionarCards()
                }
            }
        }
    }
}
extension CombineVC{
    func adicionarFooter() {
        let stackView: UIStackView = UIStackView(arrangedSubviews: [UIView(),desLikeButton,superLikeButton,likeButton,UIView()])
        stackView.distribution = .equalCentering
        view.addSubview(stackView)
        stackView.preencher(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor,padding: .init(top: 0, left: 16, bottom: 34, right: 16))
        self.desLikeButton.addTarget(self, action: #selector(dislikeClick), for: .touchUpInside)
        self.likeButton.addTarget(self, action: #selector(likeClick), for: .touchUpInside)
        self.superLikeButton.addTarget(self, action: #selector(superLikeClick), for: .touchUpInside)
    }
    func adicionaHeader(){
        let window = UIApplication.shared.windows.first{$0.isKeyWindow}
        let top: CGFloat = window?.safeAreaInsets.top ?? 44
        let stackView = UIStackView(arrangedSubviews: [perfilButton,logoButton,chatButton ])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        stackView.preencher(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil,padding: .init(top: top, left: 16, bottom: 0, right: 16))
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
            view.insertSubview(card, at: 1)
        }
        
    }
    func removerCard(_ card:UIView){
        card.removeFromSuperview()
        self.usuarios = self.usuarios.filter { (usuario) -> Bool in
            return usuario.id != card.tag
        }
    }
    func verificarMatch(usuario:Usuario){
        if usuario.match{
           let matchVC = MatchVC()
            matchVC.usuario = usuario
            matchVC.modalPresentationStyle = .fullScreen 
            self.present(matchVC,animated: true,completion: nil)
        }
    }
}
extension CombineVC{
    
    @objc func dislikeClick(){
        self.animarCard(rotationAngle: -0.4, acao: .dislike)
    }
    @objc func likeClick(){
        self.animarCard(rotationAngle: 0.4, acao: .like)
    }
    @objc func superLikeClick(){
        self.animarCard(rotationAngle: 0, acao: .superlike)
    }
    
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
                if card.center.x > self.view.bounds.width + 50 {
                    animarCard(rotationAngle: rotateAngle, acao: .like)
                    return
                } else if card.center.x < -50 {
                    animarCard(rotationAngle: rotateAngle, acao: .dislike )
                    return
                }
                self.removerCard(card)
                UIView.animate(withDuration: 0.2){
                    card.transform = .identity
                    card.center = self.view.center
                    card.likeImageView.alpha = 0
                    card.dislikeImageView.alpha = 0
                }
                
            }
        }
        
    }
    func animarCard(rotationAngle:CGFloat, acao: acao){
        if let usuario = self.usuarios.first {
            for view in self.view.subviews{
                if view.tag == usuario.id{
                    if let card = view as? CombinaCardView{
                        let center: CGPoint
                        var like: Bool
                        switch acao {
                        case .dislike:
                            center = CGPoint(x: card.center.x - self.view.bounds.width, y: card.center.y + 50)
                            like = false
                        case.superlike:
                            center = CGPoint(x: card.center.x, y: card.center.y - self.view.bounds.height)
                            like = true
                        case .like:
                            center = CGPoint(x: card.center.x + self.view.bounds.width, y: card.center.y - 50)
                            like = true
                        }
                        card.likeImageView.alpha = like ? 1:0
                        card.dislikeImageView.alpha = like ? 0:1
                        
                        UIView.animate(withDuration: 0.2, animations: { card.center = center
                            card.transform = CGAffineTransform(rotationAngle: rotationAngle)}, completion: {(_) in
                                if like {
                                    self.verificarMatch(usuario: usuario)
                                }
                                self.removerCard(card)
                        })
                    }
                }
            }
        }
    }
    
}
