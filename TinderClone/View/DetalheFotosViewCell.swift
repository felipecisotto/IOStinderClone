//
//  DetalheFotosViewCell.swift
//  TinderClone
//
//  Created by Felipe Cisotto on 22/04/20.
//  Copyright © 2020 Felipe Cisotto. All rights reserved.
//

import UIKit

class DetalheFotosCell: UICollectionViewCell {
    
    let descricaoLabel: UILabel = .textBoldLabel(size: 16)
    
    let slideFotosVC = SlideFotosVC()
    
    override init(frame: CGRect) {
        super.init(frame:frame)

        descricaoLabel.text = "Fotos recentes do instagram"
        
        addSubview(descricaoLabel)
        descricaoLabel.preencher(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil,padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        addSubview(slideFotosVC.view)
        slideFotosVC.view.preencher(top: descricaoLabel.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
