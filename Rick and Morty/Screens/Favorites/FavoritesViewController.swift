//
//  FavoritesViewController.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 24/01/21.
//

import UIKit

class FavoritesViewController: BaseViewController {
    
    
    // MARK: - Components
    private let tableView = UITableView()
    private let activityIndicatorView = UIActivityIndicatorView()
    
    
    // MARK: - Private Properties
    private var characters: [CharacterModel] = []
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadData()
    }

    
    // MARK: - Initialization
    class func createModule() -> FavoritesViewController {
        let controller = FavoritesViewController()
        return controller
    }
    
    
    // MARK: - ViewSetup
    override func buildHierarchy() {
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        tableView.attachTo(safeArea: safeArea)
    }
    
    override func configureViews() {
        view.backgroundColor = UIColor.mainBackground
        title = kFavoritesTabBarTitle
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "characterCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .lightGray
        activityIndicatorView.startAnimating()
        tableView.backgroundView = activityIndicatorView
    }
    
    
    // MARK: - Behaviours
    private func loadData() {
        let favoriteCharacters = FavoriteCharactersManager.shared.getAll()
        characters.removeAll()
        tableView.reloadData()
        
        ServiceManager.shared.getFavoriteCharacters(favorites: favoriteCharacters) { [weak self] (characters) in
            guard let welf = self else { return }
            welf.characters = characters
            welf.tableView.reloadData()
        }
    }
    
}


// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if characters.count == 0 {
            activityIndicatorView.startAnimating()
        } else if tableView.backgroundView != nil {
            activityIndicatorView.stopAnimating()
        }
        
        return characters.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") as! CharacterTableViewCell
        let character = characters[indexPath.row]
        
        cell.configure(character: character, isFavorite: true)
        cell.delegate = self
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kCharacterCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let character = characters[indexPath.row]
        let detailsVC = DetailViewController.createModule(character: character)
        
        navigationController?.pushViewController(detailsVC, animated: true)    
    }
    
}


// MARK: - FavoriteButtonDelegate
extension FavoritesViewController: FavoriteButtonDelegate {
    
    func onFavoriteButtonClick(characterID: Int, isFavorite: Bool) {
        if !isFavorite {
            if let characterIndex = characters.firstIndex(where: { $0.id == characterID }) {
                characters.remove(at: characterIndex)
                tableView.deleteRows(at: [IndexPath(row: characterIndex, section: 0)], with: .fade)
            }
        } else {
            loadData()
        }
    }
    
}
