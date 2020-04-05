//
//  CombineViewController.swift
//  TinderClone
//
//  Created by Felipe Cisotto on 05/04/20.
//  Copyright © 2020 Felipe Cisotto. All rights reserved.
//

import UIKit

class CombineVC:UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.systemGroupedBackground
        
        for _ in 1...3 {
              self.adicionarCards()
        }
      
     
    }
}
extension CombineVC{
    func adicionarCards() {
           let redView = UIView()
             redView.backgroundColor = .random()
        redView.frame = CGRect(x: 0, y: 0, width: view.bounds.width-32, height: view.bounds.height * 0.7)
             redView.center = view.center
             
             
             let gesture = UIPanGestureRecognizer()
             gesture.addTarget(self, action: #selector(handleCard))
             view.addSubview(redView)
             redView.addGestureRecognizer(gesture)
    }
}
extension CombineVC{
    @objc func handleCard(gesture: UIPanGestureRecognizer){
        if let card = gesture.view{
            let point = gesture.translation(in: view)
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            let rotateAngle = point.x / view.bounds.width * 0.4
            card.transform = CGAffineTransform(rotationAngle: rotateAngle)
            if gesture.state == .ended {
                UIView.animate(withDuration: 0.2){
                    card.transform = .identity
                     card.center = self.view.center
                }
               
            }
        }
        
    }
   
    }
extension CGFloat {
       static func random() -> CGFloat {
           return CGFloat(arc4random()) / CGFloat(UInt32.max)
       }
   }
   extension UIColor {
       static func random() -> UIColor {
           return UIColor(red:   .random(),
                          green: .random(),
                          blue:  .random(),
                          alpha: 1.0)
       }
}
