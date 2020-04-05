//
//  UiView.swift
//  AutoLayout2
//
//  Created by Felipe Cisotto on 04/04/20.
//  Copyright © 2020 Felipe Cisotto. All rights reserved.
//

import UIKit

extension UIView{
    func preencher(top:NSLayoutYAxisAnchor? ,leading: NSLayoutXAxisAnchor?,trailing:NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?,padding: UIEdgeInsets = .zero,size:CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    func preencherSuperView(padding: UIEdgeInsets = .zero){
        preencher(top: superview?.topAnchor, leading: superview?.leadingAnchor, trailing: superview?.trailingAnchor, bottom: superview?.bottomAnchor,padding: padding)
    }
    
    func centralizarSuperView(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superViewCenterX = superview?.centerXAnchor{
            centerXAnchor.constraint(equalTo: superViewCenterX).isActive = true
            
        }
        if let superViewCenterY = superview?.centerYAnchor{
            centerYAnchor.constraint(equalTo: superViewCenterY).isActive = true
            
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func size(size: CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
}


