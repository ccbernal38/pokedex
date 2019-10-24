//
//  MovesTableViewCell.swift
//  pokedex
//
//  Created by analisoft on 10/24/19.
//  Copyright © 2019 Christian Bernal. All rights reserved.
//

import UIKit
import Alamofire

class ItemsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameItemLabel: UILabel!
    @IBOutlet weak var imageTypeItem: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
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
        
        nameItemLabel.text = nameItemLabel.text?.capitalized
        costLabel.text = "\(data["cost"] as! Int)"
        let image = data["sprites"] as! [String:Any]
        let urlImage = image["default"] as! String
        imageTypeItem.load(url: NSURL(string: urlImage)! as URL)
    }

}
