//
//  PokemonEvolutionTableViewCell.swift
//  pokedex
//
//  Created by analisoft on 10/24/19.
//  Copyright © 2019 Christian Bernal. All rights reserved.
//

import UIKit

class PokemonEvolutionTableViewCell: UITableViewCell {
    @IBOutlet weak var pokemonOrigen: UIImageView!
    @IBOutlet weak var pokemonOrigenName: UILabel!
    @IBOutlet weak var PokemonEvolucion: UIImageView!
    @IBOutlet weak var pokemonEvolucionName: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
