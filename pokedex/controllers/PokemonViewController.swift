//
//  ViewController.swift
//  pokedex
//
//  Created by analisoft on 10/22/19.
//  Copyright © 2019 Christian Bernal. All rights reserved.
//

import UIKit
import Alamofire

class PokemonViewController: UIViewController {
   
    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listadoPokemon()
    }
    
    func listadoPokemon() {
        AF.request(Utils.urlPokemonInit)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                switch response.result
                {
                    case .success:
                        print(response.result)
                    case .failure(let error):
                        print(error)
                }
        }
    }

    
}

