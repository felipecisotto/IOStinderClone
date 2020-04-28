//
//  SlideFotoCell.swift
//  TinderClone
//
//  Created by Felipe Cisotto on 28/04/20.
//  Copyright © 2020 Felipe Cisotto. All rights reserved.
//

import UIKit

class SlideFotoCell: UICollectionViewCell {
    
    var fotoImageView: UIImageView = .fotoImageView()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        layer.cornerRadius = 8
        clipsToBounds = true
        addSubview(fotoImageView)
        fotoImageView.preencherSuperView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
