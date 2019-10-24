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
            let slot = type["slot"] as? Int ?? 0
            let type_array = type["type"] as! [String:Any]
            let name = type_array["name"] as? String ?? ""
            
            if slot == 1 {
                imageTipo2.image = UIImage(named: name.capitalized)
            } else if slot == 2 {
                imageTipo1.image = UIImage(named: name.capitalized)
            }
        }
        let url = (data["sprites"] as! [String:Any])["front_default"] as! String
        imagen.load(url: NSURL(string: url)! as URL)
    }
}
