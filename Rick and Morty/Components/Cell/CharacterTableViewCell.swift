//
//  CharacterTableViewCell.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 22/01/21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell, ViewCode {
    
    //MARK: - Components
    private let characterImageView = UIImageView()
    private let nameLabel = UILabel()
    private let detailsLabel = UILabel()//PaddingLabel(topInset: 5, bottomInset: 5)
    private let statusView = AliveStatusView()
    private let stackView = UIStackView()
    private let detailStackView = UIStackView()
    private let favoriteButton = FavoriteButton()
    
    
    //MARK: - Private
    private var character: CharacterModel?
    private let viewPadding: CGFloat = 10
    
    
    //MARK: - Public
    weak var delegate: FavoriteButtonDelegate?
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - ViewCode
    func buildHierarchy() {
        contentView.addSubview(characterImageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(detailStackView)
        stackView.addArrangedSubview(UIView())
        detailStackView.addArrangedSubview(statusView)
        detailStackView.addArrangedSubview(detailsLabel)
        contentView.addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        characterImageView.widthAnchor.constraint(equalTo: characterImageView.heightAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        favoriteButton.anchorTo(
            trailing: contentView.trailingAnchor,
            width: 40,
            height: 40,
            centerY: contentView.centerYAnchor
        )
    }
    
    func configureViews() {
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 5
        
        detailStackView.axis = .horizontal
        detailStackView.spacing = 8
        
        characterImageView.layer.masksToBounds = true
        characterImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = UIColor.mainLabel
        
        detailsLabel.textColor = UIColor.mainLabelSecundary
        detailsLabel.font = UIFont.systemFont(ofSize: 13)
        
        favoriteButton.addTarget(self, action: #selector(onFavoriteButton), for: .touchUpInside)
    }
    
    func setupUI() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async {
            self.characterImageView.layer.cornerRadius = self.characterImageView.frame.size.width / 2
        }
        
    }
    
    //MARK: - Configure
    func configure(character: CharacterModel, isFavorite: Bool) {
        self.character = character
        nameLabel.text = character.name
        
        statusView.status = AliveStatus(rawValue: character.status) ?? .unknown
        
        detailsLabel.text = "\(character.status) - \(character.species)"
                
        if let url = URL(string: character.image) {
            characterImageView.setImage(url: url)
        }
        
        favoriteButton.isFavorite = isFavorite
    }
    
    @objc func onFavoriteButton() {
        if let character = character {
            let isNowFavorite = FavoriteCharactersManager.shared.toogleFavorite(id: character.id)
            favoriteButton.isFavorite = isNowFavorite
            delegate?.onFavoriteButtonClick?(characterID: character.id, isFavorite: isNowFavorite)
        }
    }

}
