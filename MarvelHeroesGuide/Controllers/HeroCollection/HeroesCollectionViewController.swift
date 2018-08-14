 //
//  HeroesCollectionViewController.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 21.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "ObjectCell"

class HeroesCollectionViewController: UIViewController, FilterDelegate{
    func setName(name: String) {
        self.searchName = name
    }
    
    private var searchName: String?
    private var heroesList: [Character] {
        didSet {
            if heroesList.isEmpty {
                alertMessage(view: self, title: "Heores on duty", usrMessage: "No more heroes is found")
            }
        }
    }
    
    private var offsetDelta = 20
    private var totalHeroes: Int
    private var characterService: CharacterServiceProtocol
    private var currentOffset: Int = 0
    private var isLoading: Bool = false
    
    @IBOutlet fileprivate weak var heroCollectionView: UICollectionView!
    @IBOutlet fileprivate weak var loadingIndicator: UIActivityIndicatorView!
    
    
    
    @IBAction func barButtonAction() {
        let controller = FilterViewController(nibName: "TableObjectView", bundle: nil, filterDelegate: self)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func updateButton() {
        updateCharacters()
        searchName = nil
    }
    
    init(nibName: String?,
         bundle: Bundle?,
         characterService: CharacterServiceProtocol) {
        self.characterService = characterService
        self.heroesList = [Character]()
        self.totalHeroes = 0
        super.init(nibName: nibName, bundle: bundle)
    }

    
    required init?(coder aDecoder: NSCoder) {
        self.characterService = CharacterService()
        self.heroesList = [Character]()
        self.totalHeroes = 0
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Heroes"
        
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(HeroesCollectionViewController.barButtonAction))
        
        let updateItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(HeroesCollectionViewController.updateButton))
        
        self.navigationItem.rightBarButtonItems = [searchItem, updateItem]
        
        heroCollectionView.backgroundColor = Colors.backgroundMarvelRed
        
        let cellNib = UINib(nibName: "ObjectCell", bundle: nil)
        heroCollectionView?.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        heroCollectionView.dataSource = self
        heroCollectionView.delegate = self
        
        let lineSpace = CGFloat(6)
        let interitemSpace = CGFloat(6)
        let insets = UIEdgeInsetsMake(20, 0, 10, 0)
        let itemSize = UIScreen.main.bounds.width/2 - 6
        getCharacters()
        
        setLayout(lineSpace: lineSpace,
                  interitemSpace: interitemSpace,
                  insets: insets,
                  itemSize: itemSize)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let searchName = self.searchName
            else {
                if !heroesList.isEmpty {
                    updateCharacters(limit: heroesList.count)
                }
                return
        }
        updateCharacters(name: searchName)
        self.currentOffset = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pushToDescription(hero: Character) {
        let controller = HeroDescriptionController(nibName: "HeroDescription",
                                                   bundle: nil,
                                                   characterService: characterService,
                                                   character: hero)
        self.navigationController?.pushViewController(controller, animated: true)
    }


    
    
    func updateCharacters (uri: String? = nil,
                           name: String? = nil,
                           offset: Int? = 0,
                           limit: Int? = 20) {
        request(uri: uri, name: name, offset: offset, limit: limit) {
            result in self.heroesList = result
        }
    }
    
    func getCharacters(uri: String? = nil,
                       name: String? = nil,
                       offset: Int? = 0,
                       limit: Int? = 20) {
        request(uri: uri, name: name, offset: offset, limit: limit) {
            result in self.heroesList.append(contentsOf: result)
        }
    }
    
    

}


// MARK: UICollectionViewDataSource and UICollectionViewDelegate
extension HeroesCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return heroesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ObjectCell
            else { fatalError("No cell available") }
        
        let name = heroesList[indexPath.row].name
        let thumbnail = heroesList[indexPath.row].thumbnail
        cell.setOutlets(thumbnail: thumbnail, name: name)
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (heroesList.count >= totalHeroes) { return }
        if (indexPath.item == heroesList.count-1 && currentOffset < totalHeroes && !isLoading) {
            getCharacters(name: searchName, offset: currentOffset + offsetDelta, limit: offsetDelta)
            currentOffset += 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushToDescription(hero: heroesList[indexPath.row])
    }
    
    func request (uri: String? = nil,
                        name: String? = nil,
                        offset: Int? = 0,
                        limit: Int? = 20,
                        action: @escaping ([Character])->()){
        self.loadingIndicator.startAnimating()
        isLoading = true
        characterService.getCharacters(uri: uri, name: name, offset: offset, limit: limit) {
            result in
            switch result {
            case .success(let result):
                action(result.results)
                self.totalHeroes = result.total
            case .error(let error):
                print(error)
            }
            self.heroCollectionView.reloadData()
            self.loadingIndicator.stopAnimating()
            self.isLoading = false
        }
        
    }
    
    func setLayout(lineSpace: CGFloat,
                   interitemSpace: CGFloat,
                   insets: UIEdgeInsets,
                   itemSize: CGFloat) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = insets
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = lineSpace
        layout.minimumInteritemSpacing = interitemSpace
        heroCollectionView.setCollectionViewLayout(layout, animated: true)
    }

}
