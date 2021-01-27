//
//  DetailViewController.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 23/01/21.
//

import UIKit

class DetailViewController: BaseViewController {
    
    // MARK: - Components
    private let containerView = UIView()
    private let characterImageView = UIImageView()
    private let favoriteButton = FavoriteButton()
    private let nameLabel = UILabel()
    private let typeLabel = UILabel()
    private let statusLabel = UILabel()
    private let speciesLabel = UILabel()
    private let genderLabel = UILabel()
    private let originLabel = UILabel()
    private let locationLabel = UILabel()
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    
    
    // MARK: - Private Properties
    private var character: CharacterModel!
    private let viewPadding: CGFloat = 10
    private var characterImageViewSize: CGFloat {
        return view.bounds.width / 3
    }
    
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        prepareObservers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.async {
            self.characterImageView.layer.cornerRadius = self.characterImageViewSize / 2

            self.characterImageView.anchorTo(
                top: self.containerView.topAnchor, paddingTop: 10,
                width: self.characterImageViewSize,
                height: self.characterImageViewSize,
                centerX: self.containerView.centerXAnchor
            )
        }
    }
    
    
    // MARK: - Initialization
    class func createModule(character: CharacterModel) -> DetailViewController {
        let controller = DetailViewController()
        controller.character = character
        return controller
    }
    
    
    // MARK: - ViewSetup
    override func buildHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(characterImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(stackView)
        containerView.addSubview(favoriteButton)
        
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(speciesLabel)
        stackView.addArrangedSubview(genderLabel)
        stackView.addArrangedSubview(originLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(UIView())
    }
    
    override func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.anchorTo(
            leading: safeArea.leadingAnchor, paddingLeft: 0,
            top: safeArea.topAnchor, paddingTop: 0,
            trailing: safeArea.trailingAnchor, paddingRight: 0,
            bottom: safeArea.bottomAnchor, paddingBottom: 0
        )
                
        containerView.anchorTo(
            leading: scrollView.leadingAnchor,
            top: scrollView.topAnchor,
            trailing: scrollView.trailingAnchor,
            bottom: scrollView.bottomAnchor
        )
        
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        let x = containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1)
        x.priority = .defaultLow
        x.isActive = true
        
        characterImageView.anchorTo(
            top: containerView.topAnchor, paddingTop: 10,
            width: characterImageViewSize,
            height: characterImageViewSize,
            centerX: containerView.centerXAnchor
        )
        
        favoriteButton.anchorTo(
            top: containerView.topAnchor,
            trailing: containerView.trailingAnchor,
            width: 40,
            height: 40
        )
        
        nameLabel.anchorTo(
            top: characterImageView.bottomAnchor, paddingTop: viewPadding,
            centerX: characterImageView.centerXAnchor
        )
        
        stackView.anchorTo(
            leading: containerView.leadingAnchor,
            top: nameLabel.bottomAnchor, paddingTop: 25,
            trailing: containerView.trailingAnchor,
            bottom: containerView.bottomAnchor, paddingBottom: -20
        )
        
    }
    
    override func configureViews() {
        view.backgroundColor = UIColor.mainBackground
        
        characterImageView.layer.masksToBounds = true
        characterImageView.contentMode = .scaleAspectFill
        
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 5
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        nameLabel.textColor = UIColor.mainLabel
        typeLabel.textColor = UIColor.mainLabel
        statusLabel.textColor = UIColor.mainLabel
        speciesLabel.textColor = UIColor.mainLabel
        genderLabel.textColor = UIColor.mainLabel
        originLabel.textColor = UIColor.mainLabel
        locationLabel.textColor = UIColor.mainLabel
        
        favoriteButton.addTarget(self, action: #selector(onFavoriteButton), for: .touchUpInside)
    }
    
    override func setupUI() {
        super.setupUI()
        
        func getAttributed(title: String, detail: String) -> NSMutableAttributedString {
            let boldFont = UIFont.boldSystemFont(ofSize: 14)
            let regularFont = UIFont.systemFont(ofSize: 14)
            
            let attributedLabel = NSMutableAttributedString()
            attributedLabel
                .set(title, with: boldFont, color: .black)
                .set(detail, with: regularFont, color: .black)
            return attributedLabel
        }
        
        
        if let url = URL(string: character.image) {
            characterImageView.setImage(url: url)
        }
        
        nameLabel.text = character.name
        
        typeLabel.attributedText = getAttributed(title: "Type: ", detail: character.type)
        statusLabel.attributedText = getAttributed(title: "Status: ", detail: character.status)
        speciesLabel.attributedText = getAttributed(title: "Species: "  , detail: character.species)
        genderLabel.attributedText = getAttributed(title: "Gender: ", detail: character.gender)
        originLabel.attributedText = getAttributed(title: "Origin: ", detail: character.origin.name)
        locationLabel.attributedText = getAttributed(title: "Location: ", detail: character.location.name)
        
        favoriteButton.isFavorite = FavoriteCharactersManager.shared.isFavorite(id: character.id)
    }
    
    
    //MARK: - Actions
    @objc func onFavoriteButton() {
        if let character = character {
            let isNowFavorite = FavoriteCharactersManager.shared.toogleFavorite(id: character.id)

            favoriteButton.isFavorite = isNowFavorite
        }
    }
    
    //MARK: - Observer
    private func prepareObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onCharacterRemovedFromFavorites(_:)), name: .characterRemovedFromFavorites, object: nil)
    }
    
    @objc func onCharacterRemovedFromFavorites(_ notification: Notification?) {
        guard let notification = notification, let characterID = notification.object as? Int else { return }
        
        if character.id == characterID {
            favoriteButton.isFavorite = FavoriteCharactersManager.shared.isFavorite(id: character.id)
        }
    }
    
}
