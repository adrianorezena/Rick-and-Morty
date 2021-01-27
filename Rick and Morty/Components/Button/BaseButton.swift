//
//  class BaseButton- UIButton {.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 24/01/21.
//

import UIKit


class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commomInit()
    }
    
    private func commomInit() {
        addTarget(self, action: #selector(onButtonTouch), for: .touchDown)
        addTarget(self, action: #selector(onButtonRelease), for: .touchUpOutside)
        addTarget(self, action: #selector(onButtonRelease), for: .touchUpInside)
    }
    
    
    @objc private func onButtonTouch() {
        let basicAnimation = CABasicAnimation(keyPath: "transform.scale")
        basicAnimation.duration = 0.3
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.fromValue = 1.0
        basicAnimation.toValue = 1.5
        self.layer.add(basicAnimation, forKey: "layerScale")
    }
    
    @objc private func onButtonRelease() {
        let basicAnimation = CABasicAnimation(keyPath: "transform.scale")
        basicAnimation.duration = 0.2
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.fromValue = 1.5
        basicAnimation.toValue = 1.0
        self.layer.add(basicAnimation, forKey: "layerScale")
    }
    
}
