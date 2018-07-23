//
//  ConnectedHeroesCell.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 22.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import UIKit

class ConnectedHeroesCell: UITableViewCell {

    @IBOutlet fileprivate weak var heroCollectionView: UICollectionView!
    @IBOutlet fileprivate weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heroCollectionView.backgroundColor = Colors.backgroundMarvelRed
        self.backgroundColor = Colors.backgroundMarvelRed
        
        let cellNib = UINib(nibName: "HeroCell", bundle: nil)
        heroCollectionView?.register(cellNib, forCellWithReuseIdentifier: "TagCell")
        let lineSpace = CGFloat(6)
        let interitemSpace = CGFloat(6)
        let itemSize = UIScreen.main.bounds.height/4 - 6
        
        
        setLayout(lineSpace: lineSpace,
                  interitemSpace: interitemSpace,
                  itemSize: itemSize)

        }
        
    

    func setLayout(lineSpace: CGFloat,
                   interitemSpace: CGFloat,
                   itemSize: CGFloat) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = lineSpace
        layout.minimumInteritemSpacing = interitemSpace
        heroCollectionView.setCollectionViewLayout(layout, animated: true)
    }

    func reloadCollectionData() {
        self.heroCollectionView.reloadData()
    }
  
    func indicatorStartAnimating() {
        self.loadingIndicator.startAnimating()
    }
    
    func indicatorStopAnimating() {
        self.loadingIndicator.stopAnimating()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func setDataSourceAndDelegate(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {
        heroCollectionView.dataSource = dataSource
        heroCollectionView.delegate = delegate
    }
    
}
