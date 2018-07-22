//
//  HeroesCollectionViewController.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 21.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "TagCell"

class HeroesCollectionViewController: UIViewController{

    private var heroesList = [Character]()
    private var characterService: CharacterService
    private var currentOffset: Int = 0
    private var isLoading: Bool = false
    @IBOutlet fileprivate weak var heroCollectionView: UICollectionView!
    @IBOutlet fileprivate weak var loadingIndicator: UIActivityIndicatorView!
    
    init(nibName: String?,
         bundle: Bundle?,
         characterService: CharacterService) {
        self.characterService = characterService
        super.init(nibName: nibName, bundle: bundle)
    }

    
    required init?(coder aDecoder: NSCoder) {
        self.characterService = CharacterService()
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Heroes"
        heroCollectionView.backgroundColor = Colors.backgroundMarvelRed
        
        let cellNib = UINib(nibName: "HeroCell", bundle: nil)
        heroCollectionView?.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        heroCollectionView.dataSource = self
        heroCollectionView.delegate = self
        let lineSpace = CGFloat(6)
        let interitemSpace = CGFloat(6)
        let insets = UIEdgeInsetsMake(20, 3, 10, 3)
        let itemSize = UIScreen.main.bounds.width/2 - 6
        setLayout(lineSpace: lineSpace,
                  interitemSpace: interitemSpace,
                  insets: insets,
                  itemSize: itemSize)
        getCharackters()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HeroCell
            else { fatalError("No cell available") }
        
        let name = heroesList[indexPath.row].name
        let thumbnail = heroesList[indexPath.row].uriImage
        cell.setOutlets(thumbnail: thumbnail, name: name)
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.currentOffset+=20
        if (indexPath.item == heroesList.count-1 && !isLoading) {
           
            getCharackters(offset: currentOffset)
        }
    }
    
    func getCharackters(name: String? = nil,
                        offset: Int? = 0,
                        limit: Int? = 20){
        self.loadingIndicator.startAnimating()
        isLoading = true
        characterService.getCharacters(name: name, offset: offset, limit: limit) {
            result in
            switch result {
            case .success(let result):
                self.heroesList.append(contentsOf: result)
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
