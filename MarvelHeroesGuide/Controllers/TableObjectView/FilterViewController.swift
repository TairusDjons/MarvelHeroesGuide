//
//  FilterViewController.swift
//  MarvelHeroesGuide
//
//  Created by Tairus Djons on 26.07.2018.
//  Copyright © 2018 Tairus Djons. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    private var nameCell: FilterNameCell?
    private var filterDel: FilterDelegate
    
    @IBOutlet weak var FilterTableView: UITableView!
    @IBAction func okButton() {
        guard let cell = nameCell
            else {return}
        
        filterDel.setName(name: cell.getName())
        self.navigationController?.popViewController(animated: true)
    }
    
    
    init(nibName: String?,
         bundle: Bundle?,
         filterDelegate: FilterDelegate) {
        
        self.filterDel = filterDelegate
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let item = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(FilterViewController.okButton))
        self.navigationItem.rightBarButtonItem = item
        
        let cell = UINib(nibName: "interfaceTableCell", bundle: nil)
        FilterTableView.register(cell, forCellReuseIdentifier: "InterfaceCell")
        FilterTableView.backgroundColor = Colors.backgroundMarvelRed
        
        FilterTableView.dataSource = self
        FilterTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InterfaceCell") as? FilterNameCell
                else {return UITableViewCell()}
            self.nameCell = cell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    
    
}
