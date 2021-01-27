//
//  AliveStatusView.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 24/01/21.
//

import UIKit

enum AliveStatus: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}


class AliveStatusView: UIView, ViewCode {
        
    //MARK: - Components
    private let statusView = UIView()
    
    
    //MARK: - Public
    var status: AliveStatus = .unknown {
        didSet {
            switch status {
                case .alive:
                    statusView.backgroundColor = .green
                    
                case .dead:
                    statusView.backgroundColor = .red
                    
                default:
                    statusView.backgroundColor = .lightGray
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        addSubview(statusView)
    }
    
    func setupConstraints() {
        statusView.anchorTo(
            width: 8,
            height: 8,
            centerX: self.centerXAnchor,
            centerY: self.centerYAnchor
        )
    }
    
    func configureViews() {
        statusView.layer.cornerRadius = 4
        statusView.layer.masksToBounds = true
    }
    
    func setupUI() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
    
}

