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

class HeroesCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    private var heroesList = [Character]()
    private var characterService: CharacterService
    private var currentOffset: Int = 0
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

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
    
    func getCharackters(){
        self.loadingIndicator.startAnimating()
        characterService.getCharacters() {
            result in
            switch result {
            case .success(let result):
                self.heroesList = result
               
            case .error(let error):
                print(error)
            }
            self.heroCollectionView.reloadData()
            self.loadingIndicator.stopAnimating()
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
