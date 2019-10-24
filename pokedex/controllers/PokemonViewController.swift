//
//  ViewController.swift
//  pokedex
//
//  Created by analisoft on 10/22/19.
//  Copyright © 2019 Christian Bernal. All rights reserved.
//

import UIKit
import Alamofire

class PokemonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var pokeArray: [[String:Any]] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellPokemon", for: indexPath) as! PokemonTableViewCell
        let row = self.pokeArray[indexPath.row]
        cell.nombre.text = row["name"] as? String ?? ""
        cell.url = row["url"] as? String ?? ""
        cell.cargarInfo()
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listadoPokemon()
    }
    
    func listadoPokemon() {
        AF.request(Utils.urlPokemonInit,headers: [
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
                                    self.pokeArray.append(pokemon)
                                }
                                self.tableview.reloadData()
                            }
                        }
                    case .failure(let error):
                        print(error)
                }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
        
        let currentCell = tableView.cellForRow(at: indexPath!) as! PokemonTableViewCell
        
            print(currentCell.nombre!.text)
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PokemonSingleStoryboard") as? PokemonSingleViewController {
            vc.modalPresentationStyle = .fullScreen
            vc.data = currentCell.data
            if ((currentCell.imagen.image as? UIImage) != nil) {
                vc.imagen = currentCell.imagen.image!
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
}

