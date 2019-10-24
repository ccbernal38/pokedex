//
//  Utils.swift
//  pokedex
//
//  Created by analisoft on 10/22/19.
//  Copyright © 2019 Christian Bernal. All rights reserved.
//
import UIKit

public struct Utils{

    static let url = "https://pokeapi.co/api/v2"
    static let urlPokemonInit = "\(url)/pokemon"
    static let urlPokemonSpecies = "\(url)/pokemon-species"
    
    static func colorGradient(type:String, bounds:CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        let color1:UIColor = UIColor(named: "color_\(type)-1")!
        let color2:UIColor = UIColor(named: "color_\(type)-2")!
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5) // Left side.
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5) // Right side.
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]

        return gradientLayer
    }
    
    static func getColorByType(type:String)->UIColor {
        let name_color = "color_\(type)"
        return UIColor(named: name_color)!
    }
}
