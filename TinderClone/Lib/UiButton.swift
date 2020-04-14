//
//  UiButton.swift
//  TinderClone
//
//  Created by Felipe Cisotto on 05/04/20.
//  Copyright © 2020 Felipe Cisotto. All rights reserved.
//

import UIKit

extension UIButton{
    
    static func iconMenu(named: String) -> UIButton{
        let button = UIButton()
        button.size(size: .init(width: 32, height: 32))
        button.setImage(UIImage(named: named), for: .normal)
        return button
    }
    
    static func iconFooter(named: String) -> UIButton{
        let button = UIButton()
        button.size(size: .init(width: 64, height: 64))
        button.setImage(UIImage(named:named), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.masksToBounds = false
    
        return button
    }
    
}
