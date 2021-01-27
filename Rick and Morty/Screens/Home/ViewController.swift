//
//  ViewController.swift
//  Rick and Morty
//
//  Created by Adriano Rezena on 22/01/21.
//

import UIKit

protocol ViewCode {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
    func setupUI()
}

class BaseViewController: UIViewController, ViewCode {
    
    func buildHierarchy() {}
    
    func setupConstraints() {}
    
    func configureViews() {}
    
    func setupUI() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
    
}

class HomeViewController: BaseViewController {

    // MARK: - Components
    //private let tableView = UITableView(frame: .zero)
    private let tableView = UITableView()
    
    // MARK: - Private
    private var characters: [CharacterModel] = []
    private var safeArea: UILayoutGuide!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        safeArea = view.layoutMarginsGuide
        setupUI()
        ServiceManager.shared.getCharacters { [weak self] (characters) in
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
        //tableView.attachTo(containerView: view)
        tableView.attachTo(safeArea: safeArea)
    }
    
    override func configureViews() {
        view.backgroundColor = UIColor.mainBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "characterCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    
}

extension HomeViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") as! CharacterTableViewCell
        let character = characters[indexPath.row]
        
        cell.configure(name: character.name, type: character.type, imageURL: character.image)
        
        
//        cell.textLabel?.text = character.name
//        cell.detailTextLabel?.text = "\(character.id)"
//        if let url = URL(string: character.image) {
//            cell.imageView?.setImage(url: url)
//        }
        
        return cell
    }
    
}


extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

