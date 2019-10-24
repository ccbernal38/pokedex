//
//  MovesTableViewCell.swift
//  pokedex
//
//  Created by analisoft on 10/24/19.
//  Copyright © 2019 Christian Bernal. All rights reserved.
//

import UIKit
import Alamofire

class MovesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameMoveLabel: UILabel!
    @IBOutlet weak var imageTypeMove: UIImageView!
    var url:String = ""
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
        
        nameMoveLabel.text = nameMoveLabel.text?.capitalized
        let type = data["type"] as! [String:Any]
        
        var name = type["name"] as? String ?? ""
        if name == "fighting" {
            name = "fight"
        }
        imageTypeMove.image = UIImage(named: name.capitalized)
    }

}
