//
//  PokemonTableViewCell.swift
//  pokedex
//
//  Created by analisoft on 10/22/19.
//  Copyright © 2019 Christian Bernal. All rights reserved.
//

import UIKit
import Alamofire
class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var numero: UILabel!
    @IBOutlet weak var imageTipo1: UIImageView!
    @IBOutlet weak var imageTipo2: UIImageView!
    
    var url = ""
    var data:[String:Any] = [:]
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func cargarInfo(){
        AF.request(self.url,headers: [
        "Content-Type": "application/json",
        "Accept": "application/json",
        ]).responseJSON(completionHandler: {
            response in
            switch response.result
            {
                case .success:
                    if let json = response.value as? [String:Any] {
                        
                            self.data = json
                            self.setData()
                        
                    }
                case .failure(let error):
                    print(error)
            }
        })
    }
    
    func setData(){
        let id = data["id"] as? Int ?? 0
        if id < 10 {
            numero.text = "#00\(id)"
        }else if id < 100 {
            numero.text = "#0\(id)"
        }else{
            numero.text = "#\(id)"
        }
        nombre.text = nombre.text?.capitalized
        let types = data["types"] as! [[String:Any]]
        for type in types {
            var slot = type["slot"] as? Int ?? 0
            let type_array = type["type"] as! [String:Any]
            let name = type_array["name"] as? String ?? ""
            
            if slot == 1 {
                if name.capitalized == "Bug" {
                    imageTipo2.image = UIImage(named: "Bug")
                } else if name.capitalized == "Dark" {
                    imageTipo2.image = UIImage(named: "Dark")
                } else if name.capitalized == "Dragon" {
                    imageTipo2.image = UIImage(named: "Dragon")
                } else if name.capitalized == "Electric" {
                    imageTipo2.image = UIImage(named: "Electric")
                } else if name.capitalized == "Fairy" {
                    imageTipo2.image = UIImage(named: "Fairy")
                } else if name.capitalized == "Fight" {
                    imageTipo2.image = UIImage(named: "Fight")
                } else if name.capitalized == "Fire" {
                    imageTipo2.image = UIImage(named: "Fire")
                } else if name.capitalized == "Flying" {
                    imageTipo2.image = UIImage(named: "Flying")
                } else if name.capitalized == "Ghost" {
                    imageTipo2.image = UIImage(named: "Ghost")
                } else if name.capitalized == "Grass" {
                    imageTipo2.image = UIImage(named: "Grass")
                } else if name.capitalized == "Ground" {
                    imageTipo2.image = UIImage(named: "Ground")
                } else if name.capitalized == "Ice" {
                    imageTipo2.image = UIImage(named: "Ice")
                } else if name.capitalized == "Normal" {
                    imageTipo2.image = UIImage(named: "Normal")
                } else if name.capitalized == "Poison" {
                    imageTipo2.image = UIImage(named: "Poison")
                } else if name.capitalized == "Psychic" {
                    imageTipo2.image = UIImage(named: "Psychic")
                } else if name.capitalized == "Rock" {
                    imageTipo2.image = UIImage(named: "Rock")
                } else if name.capitalized == "Steel" {
                    imageTipo2.image = UIImage(named: "Steel")
                } else if name.capitalized == "Water" {
                    imageTipo2.image = UIImage(named: "Water")
                }
            } else if slot == 2 {
                if name.capitalized == "Bug" {
                    imageTipo1.image = UIImage(named: "Bug")
                } else if name.capitalized == "Dark" {
                    imageTipo1.image = UIImage(named: "Dark")
                } else if name.capitalized == "Dragon" {
                    imageTipo1.image = UIImage(named: "Dragon")
                } else if name.capitalized == "Electric" {
                    imageTipo1.image = UIImage(named: "Electric")
                } else if name.capitalized == "Fairy" {
                    imageTipo1.image = UIImage(named: "Fairy")
                } else if name.capitalized == "Fight" {
                    imageTipo1.image = UIImage(named: "Fight")
                } else if name.capitalized == "Fire" {
                    imageTipo1.image = UIImage(named: "Fire")
                } else if name.capitalized == "Flying" {
                    imageTipo1.image = UIImage(named: "Flying")
                } else if name.capitalized == "Ghost" {
                    imageTipo1.image = UIImage(named: "Ghost")
                } else if name.capitalized == "Grass" {
                    imageTipo1.image = UIImage(named: "Grass")
                } else if name.capitalized == "Ground" {
                    imageTipo1.image = UIImage(named: "Ground")
                } else if name.capitalized == "Ice" {
                    imageTipo1.image = UIImage(named: "Ice")
                } else if name.capitalized == "Normal" {
                    imageTipo1.image = UIImage(named: "Normal")
                } else if name.capitalized == "Poison" {
                    imageTipo1.image = UIImage(named: "Poison")
                } else if name.capitalized == "Psychic" {
                    imageTipo1.image = UIImage(named: "Psychic")
                } else if name.capitalized == "Rock" {
                    imageTipo1.image = UIImage(named: "Rock")
                } else if name.capitalized == "Steel" {
                    imageTipo1.image = UIImage(named: "Steel")
                } else if name.capitalized == "Water" {
                    imageTipo1.image = UIImage(named: "Water")
                }
            }
        }
        if types.count == 2 {
            var type = types[0] as! [String:Any]
            /**
            */
        }else{
            
        }
        let url = (data["sprites"] as! [String:Any])["front_default"] as! String
        imagen.load(url: NSURL(string: url)! as URL)
    }
    
        
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
