//
//  UIView+Extension.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 22/01/21.
//

import UIKit

extension UIView {
    
    func attachTo(safeArea: UILayoutGuide) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true
        leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0).isActive = true
        trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0).isActive = true
    }
    
//    func attachTo(containerView: UIView, clearContainer: Bool = false) {
//        if clearContainer {
//            containerView.subviews.forEach({ $0.removeFromSuperview() })
//        }
//
//        containerView.addSubview(self)
//        translatesAutoresizingMaskIntoConstraints = false
//        topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
//        bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
//        leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
//        trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
//    }
    
    
    func anchorTo (
        leading: NSLayoutXAxisAnchor? = nil,
        paddingLeft: CGFloat = 0,
        top: NSLayoutYAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        trailing: NSLayoutXAxisAnchor? = nil,
        paddingRight: CGFloat = 0,
        bottom: NSLayoutYAxisAnchor? = nil,
        paddingBottom: CGFloat = 0,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        centerX: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil,
        canLog: Bool = false) {

        translatesAutoresizingMaskIntoConstraints = false
        constraints.forEach({ $0.isActive = false })
        
        if let leading = leading {
            if canLog{ print("🖼 leadingAnchor with \(paddingLeft) padding") }
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }

        if let top = top {
            if canLog{ print("🖼 topAnchor with \(paddingTop) padding") }
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let trailing = trailing {
            if canLog{ print("🖼 trailingAnchor with \(paddingRight) padding") }
            self.trailingAnchor.constraint(equalTo: trailing, constant: paddingRight).isActive = true
        }

        if let bottom = bottom {
            if canLog{ print("🖼 bottomAnchor with \(paddingBottom) padding") }
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let width = width {
            if canLog{ print("🖼 widthAnchor equalToConstant \(width)") }
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            if canLog{ print("🖼 heightAnchor equalToConstant \(height)") }
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let centerX = centerX {
            if canLog{ print("🖼 centerXAnchor") }
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            if canLog{ print("🖼 centerYAnchor") }
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }

    }
    
}
