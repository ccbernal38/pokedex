//
//  PokemonSingleTableViewCell.swift
//  pokedex
//
//  Created by analisoft on 10/23/19.
//  Copyright © 2019 Christian Bernal. All rights reserved.
//

import UIKit
import Alamofire

class PokemonSingleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageHide: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var url:String = ""
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func cargarInfo() {
        AF.request(self.url,headers: [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]).responseJSON(completionHandler: {
            response in
            switch response.result
            {
            case .success:
                if let json = response.value as? [String:Any] {
                    let effect_entries = json["flavor_text_entries"] as! [[String:Any]]
                    for effect in effect_entries{
                        let language = effect["language"] as! [String:Any]
                        if language["name"] as! String == "en" {
                            let flavor_text = effect["flavor_text"] as! String
                            self.descriptionLabel.text = flavor_text.replacingOccurrences(of: "\n", with: " ")
                            
                            break
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
