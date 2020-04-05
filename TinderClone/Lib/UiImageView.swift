//
//  UiImageView.swift
//  TinderClone
//
//  Created by Felipe Cisotto on 05/04/20.
//  Copyright © 2020 Felipe Cisotto. All rights reserved.
//

import UIKit

extension UIImageView{
    static func fotoImageView(named: String? = nil) -> UIImageView{
        let imageView = UIImageView()
        if let named = named {
            imageView.image = UIImage(named: named)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }
    static func iconCard (named: String) -> UIImageView {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: named)
        imageView.size(size: .init(width: 70, height: 70))
        imageView.alpha = 0.0
        return imageView
        
    }
}
