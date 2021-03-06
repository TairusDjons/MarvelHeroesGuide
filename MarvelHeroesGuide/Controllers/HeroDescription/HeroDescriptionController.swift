//
//  HeroDescriptionController.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 22.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import UIKit

class HeroDescriptionController: UIViewController {

    private var hero: Character?
    
    private var connectedHeroes = [Character]() {
        didSet {
            guard let cell = connectedHeroCell,
                      connectedHeroes.isEmpty
                else { return }
            
            cell.reloadCollectionData()
            
            guard !connectedHeroes.isEmpty
                else {
                    self.connectedHeroCell?.setNoConnectedLabel(string: "Seems this hero prefer be lone wolf")
                    return
            } 
        }
    }
    private var eventCounter = 0
    private var currentOffset = 0
    private var totalHeroes = 0
    private var isLoading: Bool = false
    private var connectedHeroCell: ConnectedHeroesCell?
    private let characterService: CharacterServiceProtocol
    
    
    @IBOutlet weak var interfaceTableView: UITableView!
    @IBAction func wikiButtonAction(sender: UIButton){
        guard let hero = self.hero
            else { return }
        pushToWiki(hero: hero)
    }
    
    init(nibName: String?,
         bundle: Bundle?,
         characterService: CharacterServiceProtocol,
         character: Character) {
        self.characterService = characterService
        self.hero = character
        super.init(nibName: nibName, bundle: bundle)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        self.characterService = CharacterService()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let hero = self.hero
            else {
                alertMessage(view: self,
                             title: "He was here! But flies away",
                             usrMessage: "Hero data is not found, maybe problem is in bad connection")
                return
                
        }
        self.title = hero.name
        
        interfaceTableView.backgroundView?.backgroundColor = Colors.backgroundMarvelRed
        interfaceTableView.backgroundColor = Colors.backgroundMarvelRed
        setupTableView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        let thumbnail = UINib(nibName: "HeroThumbnailCell", bundle: nil)
        let detail = UINib(nibName: "HeroDetailsCell", bundle: nil)
        let connectedHeroes = UINib(nibName: "ConnectedHeroesCell", bundle: nil)
        let wikiButton = UINib(nibName: "WikiButtonCell", bundle: nil)
        
        interfaceTableView.register(thumbnail, forCellReuseIdentifier: "ThumbnailCell")
        interfaceTableView.register(detail, forCellReuseIdentifier: "DetailCell")
        interfaceTableView.register(connectedHeroes, forCellReuseIdentifier: "ConnectedHeroesCell")
        interfaceTableView.register(wikiButton, forCellReuseIdentifier: "WikiButtonCell")
        
        interfaceTableView.dataSource = self
        interfaceTableView.delegate = self
    }
    
  
    func getConnectedCharacters(character: Character,
                                offset: Int? = 0,
                                eventCounter: Int? = 0,
                                limit: Int? = 20) {
        isLoading = true
        guard let character = self.hero,
              character.events.available != 0,
              let collectionCell = self.connectedHeroCell
            else {
                self.connectedHeroCell?.setNoConnectedLabel(string: "Seems this hero prefer be lone wolf")
                return
                
        }
        
        collectionCell.indicatorStartAnimating()
        
        let event = character.events.items[eventCounter!]
        
        characterService.getCharactersBy(event: event.resourceURI, offset: offset, limit: limit) {
            result in switch result {
            case .success(let result):
                
                self.totalHeroes = result.total
                if result.results.isEmpty {
                    self.eventCounter += 1
                    self.currentOffset = 0
                }
                else {
                    let heroesSet = Set(result.results)
                    self.connectedHeroes.append(contentsOf: heroesSet.subtracting(self.connectedHeroes))
                    self.currentOffset = offset!
                }
            case .error(_):
                print("ohhh")
            }
            collectionCell.indicatorStopAnimating()
            collectionCell.reloadCollectionData()
            self.isLoading = false

        }
        
    }
    
    
    func pushToDescription(hero: Character) {
        let controller = HeroDescriptionController(nibName: "HeroDescription",
                                                   bundle: nil,
                                                   characterService: characterService,
                                                   character: hero)
        pushTo(controller: controller)
    }
    
    func pushToWiki(hero: Character) {
        let controller = WikiWebViewController(nibName: "WikiWebView",
                                               bundle: nil,
                                               character: hero)
        pushTo(controller: controller)
    }
    
    func pushTo(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}


extension HeroDescriptionController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hero = self.hero
            else {return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThumbnailCell") as? ThumbnailCell
                else {return UITableViewCell()}
            cell.setOutlets(thumbnail: hero.thumbnail, name: hero.name)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailCell
                else {return UITableViewCell()}
            cell.setOutlets(description: hero.description)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectedHeroesCell") as? ConnectedHeroesCell
                else {return UITableViewCell()}
            cell.setDataSourceAndDelegate(dataSource: self, delegate: self)
            self.connectedHeroCell = cell
            getConnectedCharacters(character: hero)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WikiButtonCell") as? WikiButtonCell
                else {return UITableViewCell()}
            cell.setAction(target: self, action: #selector(wikiButtonAction(sender:)), event: .touchUpInside)
            return cell
        default:
            return UITableViewCell()
        }
    }
}


extension HeroDescriptionController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return connectedHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ObjectCell", for: indexPath) as? ObjectCell
            else {return UICollectionViewCell()}
        let character = connectedHeroes[indexPath.row]
        cell.setOutlets(thumbnail: character.thumbnail, name: character.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushToDescription(hero: connectedHeroes[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let hero = self.hero
            else {return}
        
        
        guard indexPath.item == connectedHeroes.count - 1,
              currentOffset < totalHeroes,
              !isLoading,
              eventCounter < hero.events.available
            else {return}
        getConnectedCharacters(character: hero, offset: currentOffset + 5, eventCounter: self.eventCounter)
    }
    
    
    
}
