//
//  MovesViewController.swift
//  pokedex
//
//  Created by analisoft on 10/24/19.
//  Copyright © 2019 Christian Bernal. All rights reserved.
//

import UIKit
import Alamofire

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var itemsArray:[[String:Any]] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsTableViewCell", for: indexPath) as! ItemsTableViewCell
        let row = self.itemsArray[indexPath.row]
        cell.nameItemLabel.text = row["name"] as? String ?? ""
        cell.url = row["url"] as? String ?? ""
        cell.cargarInfo()
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getMoves()
        // Do any additional setup after loading the view.
    }
    
    func getMoves() {
        AF.request(Utils.urlItems,headers: [
        "Content-Type": "application/json",
        "Accept": "application/json",
        ])
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                switch response.result
                {
                    case .success:
                        if let json = response.value as? NSDictionary {
                            if let result = json["results"] as? [[String:Any]] {
                                for pokemon in result {
                                    self.itemsArray.append(pokemon)
                                }
                                self.tableview.reloadData()
                            }
                        }
                    case .failure(let error):
                        print(error)
                }
        }    }

    

}
