//
//  DetalheHeaderView.swift
//  TinderClone
//
//  Created by Felipe Cisotto on 21/04/20.
//  Copyright © 2020 Felipe Cisotto. All rights reserved.
//

import UIKit

class DetalheHeaderView:UICollectionReusableView{
    
    var fotoImageView: UIImageView = .fotoImageView()
    var usuario:Usuario?{
          didSet{
              if let usuario = usuario {
                fotoImageView.image = UIImage(named: usuario.foto)
              }
              
          }
      }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(fotoImageView)
        fotoImageView.preencherSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
