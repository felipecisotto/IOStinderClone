//
//  CombineCardView.swift
//  TinderClone
//
//  Created by Felipe Cisotto on 05/04/20.
//  Copyright © 2020 Felipe Cisotto. All rights reserved.
//

import UIKit

class CombinaCardView: UIView {
    
    var usuario:Usuario?{
        didSet{
            if let usuario = usuario {
                fotoImagemView.image = UIImage(named: usuario.foto)
                nomeLabel.text = usuario.nome
                idadeLabel.text = String(usuario.idade)
                fraseLabel.text = usuario.frase
            }
        }
    }
    
    let fotoImagemView : UIImageView = .fotoImageView()
    
    let nomeLabel: UILabel = .textBoldLabel(size: 32, textColor: .white)
    let idadeLabel: UILabel = .textLabel(size:28, textColor: .white)
    let fraseLabel: UILabel = .textLabel(size: 18,textColor: .white,numberOfLines: 2)
    
    let dislikeImageView: UIImageView = .iconCard(named:"card-dislike")
    let likeImageView: UIImageView = .iconCard(named:"card-like")
    
    var callback: ((Usuario) -> Void)?
    
    override init(frame: CGRect) {
        
        super.init(frame:frame)
        
        layer.borderWidth = 0.3
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
        nomeLabel.adicionaShadow()
        idadeLabel.adicionaShadow()
        fraseLabel.adicionaShadow()
        
        addSubview(fotoImagemView)
        addSubview(dislikeImageView)
        dislikeImageView.preencher(top: topAnchor, leading: nil, trailing: trailingAnchor, bottom: nil,padding: .init(top: 20, left: 0, bottom: 0, right: 20))
        addSubview(likeImageView)
        likeImageView.preencher(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: nil,padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        fotoImagemView.preencherSuperView()
        
        let nomeIdadeStackView = UIStackView(arrangedSubviews: [nomeLabel,idadeLabel,UIView()])
        nomeIdadeStackView.spacing = 12
        
        let fraseStackView = UIStackView(arrangedSubviews: [nomeIdadeStackView,fraseLabel])
        fraseStackView.distribution = .fillEqually
        fraseStackView.axis = .vertical
        addSubview(fraseStackView)
        
        fraseStackView.preencher(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor,padding: .init(top: 0, left: 16, bottom: 15, right: 16))
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(visualizarUsuario))
        
        fraseStackView.isUserInteractionEnabled = true
        fraseStackView.addGestureRecognizer(tap)
        
        
    }
    @objc func visualizarUsuario(){
        if let usuario = self.usuario {
            self.callback?(usuario)
        }
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

