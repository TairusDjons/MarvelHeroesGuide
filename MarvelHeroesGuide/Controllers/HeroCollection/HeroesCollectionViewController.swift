//
//  HeroesCollectionViewController.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 21.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TagCell"

class HeroesCollectionViewController: UICollectionViewController {

    var heroesList = [Character]()
    var characterService: CharacterService
    
    
    @IBOutlet weak var heroCollectionView: UICollectionView!
    
    
    init(nibName: String?,
         bundle: Bundle?,
         characterService: CharacterService) {
        self.characterService = characterService
        super.init(nibName: nibName, bundle: bundle)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "TagCell", bundle: nil)
        self.collectionView?.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
        
        let lineSpace = CGFloat(4)
        let interitemSpace = CGFloat(4)
        let insets = UIEdgeInsetsMake(20, 0, 10, 0)
        let itemSize = UIScreen.main.bounds.width/3 - 4
        setLayout(lineSpace: lineSpace,
                  interitemSpace: interitemSpace,
                  insets: insets,
                  itemSize: itemSize)
        
        
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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return heroesList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    func getCharackters(){
        characterService.getCharacters() {
            result in
            switch result {
            case .success(let result):
                self.heroesList = result
            
            case .error(let error):
                print(error)
            }
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
        
        heroCollectionView.collectionViewLayout = layout
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
