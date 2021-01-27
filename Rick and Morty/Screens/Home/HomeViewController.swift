//
//  ViewController.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 22/01/21.
//

import UIKit


class HomeViewController: BaseViewController {

    
    // MARK: - Components
    private let tableView = UITableView()
    
    
    // MARK: - Private Properties
    private var characters: [CharacterModel] = []
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        ServiceManager.shared.listCharacters { [weak self] (characters) in
            guard let welf = self else { return }
            welf.characters = characters
            welf.tableView.reloadData()
        }
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
        title = kHomeTabBarTitle
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "characterCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        prepareObservers()
    }
    
    //MARK: - Observer
    private func prepareObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onCharacterRemovedFromFavorites(_:)), name: .characterRemovedFromFavorites, object: nil)
    }
    
    @objc func onCharacterRemovedFromFavorites(_ notification: Notification?) {
        guard let notification = notification, let characterID = notification.object as? Int else { return }
        
        if let characterIndex = characters.firstIndex(where: { $0.id == characterID }) {
            tableView.reloadRows(at: [IndexPath(row: characterIndex, section: 0)], with: .none)
        }
    }
    
}


//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") as! CharacterTableViewCell
        let character = characters[indexPath.row]
        
        let isFavorite = FavoriteCharactersManager.shared.isFavorite(id: character.id)
        cell.configure(character: character, isFavorite: isFavorite)
        
        return cell
    }
    
}


//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
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
