//
//  BaseViewController.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 24/01/21.
//

import UIKit

class BaseViewController: UIViewController, ViewCode {
    
    var safeArea: UILayoutGuide!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        safeArea = view.layoutMarginsGuide
    }
    
    
    func buildHierarchy() {}
    
    func setupConstraints() {}
    
    func configureViews() {}
    
    func setupUI() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
    
}
