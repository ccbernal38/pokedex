//
//  PokemonSingleViewController.swift
//  pokedex
//
//  Created by analisoft on 10/22/19.
//  Copyright © 2019 Christian Bernal. All rights reserved.
//

import UIKit
import Alamofire

class PokemonSingleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var habitatUILabel: UILabel!
    @IBOutlet weak var captureUILabel: UILabel!
    @IBOutlet weak var generationUILabel: UILabel!

    
    @IBOutlet weak var ratioCatchLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var habitatLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var male_gender: UILabel!
    @IBOutlet weak var female_gender: UILabel!

    @IBOutlet weak var eggGroupLabel: UILabel!
    @IBOutlet weak var eggGroup_1: UILabel!
    @IBOutlet weak var eggGroup_2: UILabel!
    
    @IBOutlet weak var hatchTimeLabel: UILabel!
    @IBOutlet weak var stepsHatch: UILabel!
    @IBOutlet weak var cyclesHatch: UILabel!
    
    
    
    @IBOutlet weak var tableViewAbilities: UITableView!
    @IBOutlet weak var tableViewEvolutions: UITableView!
    
    @IBOutlet weak var viewFondo: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var viewBackground: UIView!
    
    @IBOutlet weak var imagenPokemon: UIImageView!
    @IBOutlet weak var imagenNormal: UIImageView!
    @IBOutlet weak var imagenShiny: UIImageView!
    @IBOutlet weak var imagenTipo1: UIImageView!
    @IBOutlet weak var imagenTipo2: UIImageView!
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var atkLabel: UILabel!
    @IBOutlet weak var defLabel: UILabel!
    @IBOutlet weak var satkLabel: UILabel!
    @IBOutlet weak var sdefLabel: UILabel!
    @IBOutlet weak var spdLabel: UILabel!
    @IBOutlet weak var weaknessesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var breedingLabel: UILabel!
    @IBOutlet weak var captureLabel: UILabel!
    @IBOutlet weak var spritesLabel: UILabel!
    @IBOutlet weak var imageNormalLabel: UILabel!
    @IBOutlet weak var imageShinyLabel: UILabel!
    
    @IBOutlet weak var hpProgressView: UIProgressView!
    @IBOutlet weak var atkProgressView: UIProgressView!
    @IBOutlet weak var defProgressView: UIProgressView!
    @IBOutlet weak var satkProgressView: UIProgressView!
    @IBOutlet weak var sdefProgressView: UIProgressView!
    @IBOutlet weak var spdProgressView: UIProgressView!
    
    @IBOutlet weak var labelUIHP: UILabel!
    @IBOutlet weak var labelUIAtk: UILabel!
    @IBOutlet weak var labelUIDef: UILabel!
    @IBOutlet weak var labelUISAtk: UILabel!
    @IBOutlet weak var labelUISDef: UILabel!
    @IBOutlet weak var labelUISPD: UILabel!
    
    var data:[String:Any] = [:]
    var poke_species:[String:Any] = [:]
    var poke_evolutions:[String:Any] = [:]
    var imagen:UIImage? = nil
    var principal_type = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        viewFondo.layer.cornerRadius = 48
        
        if imagen != nil {
            imagenPokemon.image = imagen
        }
        setData()
        
    }
    
    func setData(){
        
        //Descripcion del pokemon
        getPokemon_Species()
        
        //tag types
        let types = data["types"] as! [[String:Any]]
        if types.count == 1 {
            imagenTipo2.isHidden =  true
            imagenTipo1.contentMode = .scaleAspectFit
        }
        for type in types {
            let slot = type["slot"] as? Int ?? 0
            let type_array = type["type"] as! [String:Any]
            let name = type_array["name"] as? String ?? ""
            
            if slot == 1 {
                imagenTipo1.image = UIImage(named: "Tag_\(name.capitalized)")
                principal_type = name.capitalized
            } else if slot == 2 {
                imagenTipo2.image = UIImage(named: "Tag_\(name.capitalized)")
            }
        }
        //Color labels
        weaknessesLabel.textColor = Utils.getColorByType(type: principal_type)
        abilitiesLabel.textColor = Utils.getColorByType(type: principal_type)
        breedingLabel.textColor = Utils.getColorByType(type: principal_type)
        captureLabel.textColor = Utils.getColorByType(type: principal_type)
        spritesLabel.textColor = Utils.getColorByType(type: principal_type)
        imageNormalLabel.textColor = Utils.getColorByType(type: principal_type)
        imageShinyLabel.textColor = Utils.getColorByType(type: principal_type)
        hatchTimeLabel.textColor = Utils.getColorByType(type: principal_type)
        eggGroupLabel.textColor = Utils.getColorByType(type: principal_type)
        genderLabel.textColor = Utils.getColorByType(type: principal_type)
        habitatUILabel.textColor = Utils.getColorByType(type: principal_type)
        captureUILabel.textColor = Utils.getColorByType(type: principal_type)
        generationUILabel.textColor = Utils.getColorByType(type: principal_type)
        customButton(button: buttonStats, active: 1)
        customButton(button: buttonEvolution, active: 0)
        customButton(button: buttonMoves, active: 0)
        let color1:UIColor = UIColor(named: "color_\(principal_type)-1")!
        let color2:UIColor = UIColor(named: "color_\(principal_type)-2")!
        
        self.view.applyGradient(colours: [color1, color2], locations: [0.0, 1.0])
        
        self.view.layer.insertSublayer(Utils.colorGradient(type: principal_type, bounds: self.view.bounds), at:0)
        
        //Nombre del pokemon
        nombre.text = (data["name"] as! String).capitalized
        
        // Estadisticas Atk Def HP
        labelUIHP.textColor = Utils.getColorByType(type: principal_type)
        labelUIAtk.textColor = Utils.getColorByType(type: principal_type)
        labelUIDef.textColor = Utils.getColorByType(type: principal_type)
        labelUISAtk.textColor = Utils.getColorByType(type: principal_type)
        labelUISDef.textColor = Utils.getColorByType(type: principal_type)
        labelUISPD.textColor = Utils.getColorByType(type: principal_type)
        
        atkProgressView.tintColor = Utils.getColorByType(type: principal_type)
        hpProgressView.tintColor = Utils.getColorByType(type: principal_type)
        defProgressView.tintColor = Utils.getColorByType(type: principal_type)
        satkProgressView.tintColor = Utils.getColorByType(type: principal_type)
        sdefProgressView.tintColor = Utils.getColorByType(type: principal_type)
        spdProgressView.tintColor = Utils.getColorByType(type: principal_type)
        
        let stats = data["stats"] as! [[String:Any]]
        for stat in stats{
            let obj_stat = stat["stat"] as! [String:Any]
            let name_stat = obj_stat["name"] as! String
            let base_stat = stat["base_stat"] as! Int
            if name_stat == "special-defense" {
                if base_stat < 10 {
                    sdefLabel.text = "00\(base_stat)"
                }else if base_stat < 100{
                    sdefLabel.text = "0\(base_stat)"
                } else{
                    sdefLabel.text = "\(base_stat)"
                }
                sdefProgressView.progress = Float(base_stat)/100.0
            } else if name_stat == "speed" {
                if base_stat < 10 {
                    spdLabel.text = "00\(base_stat)"
                }else if base_stat < 100{
                    spdLabel.text = "0\(base_stat)"
                } else{
                    spdLabel.text = "\(base_stat)"
                }
                spdProgressView.progress = Float(base_stat)/100.0
            } else if name_stat == "special-attack" {
                if base_stat < 10 {
                    satkLabel.text = "00\(base_stat)"
                }else if base_stat < 100{
                    satkLabel.text = "0\(base_stat)"
                } else{
                    satkLabel.text = "\(base_stat)"
                }
                satkProgressView.progress = Float(base_stat)/100.0
            } else if name_stat == "defense" {
                if base_stat < 10 {
                    defLabel.text = "00\(base_stat)"
                }else if base_stat < 100{
                    defLabel.text = "0\(base_stat)"
                } else{
                    defLabel.text = "\(base_stat)"
                }
                defProgressView.progress = Float(base_stat)/100.0
            } else if name_stat == "attack" {
                if base_stat < 10 {
                    atkLabel.text = "00\(base_stat)"
                }else if base_stat < 100{
                    atkLabel.text = "0\(base_stat)"
                } else{
                    atkLabel.text = "\(base_stat)"
                }
                atkProgressView.progress = Float(base_stat)/100.0
            } else if name_stat == "hp" {
                if base_stat < 10 {
                    hpLabel.text = "00\(base_stat)"
                }else if base_stat < 100{
                    hpLabel.text = "0\(base_stat)"
                } else{
                    hpLabel.text = "\(base_stat)"
                }
                hpProgressView.progress = Float(base_stat)/100.0
            }
        }
        
        //Sprites
        let urlImagenNormal = (data["sprites"] as! [String:Any])["front_default"] as! String
        imagenNormal.load(url: NSURL(string: urlImagenNormal)! as URL)
        let urlImagenShiny = (data["sprites"] as! [String:Any])["front_shiny"] as! String
        imagenShiny.load(url: NSURL(string: urlImagenShiny)! as URL)
        
        
    }
    
    func getPokemon_Species(){
        AF.request("\(Utils.urlPokemonSpecies)/\(data["id"] as! Int)",headers: [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]).validate(statusCode: 200..<600)
            .responseJSON { response in
                switch response.result
                {
                case .success:
                    if let json = response.value as? [String:Any] {
                        self.poke_species = json
                        self.setPokeSpecie()
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func setPokeSpecie(){
        if self.poke_species.count > 0 {
            let array = self.poke_species

            // Asignacion de descripcion
            for obj in array["flavor_text_entries"] as! [[String:Any]]{
                let language = obj["language"] as! [String:Any]
                if language["name"] as! String == "en" {
                    let flavor_text = obj["flavor_text"] as! String
                    self.descriptionLabel.text = flavor_text
                    self.tableViewAbilities.reloadData()
                    let height = 100 * CGFloat((self.data["abilities"] as!  [[String:Any]]).count)
                    self.heightTableViewConstrain.constant = height
                    self.view.layoutIfNeeded()
                    break
                }
            }
            //Asignacion de Egg Group
            if let egg_groups = array["egg_groups"] as? [[String:Any]] {
                if egg_groups.count == 1 {
                    let egg_group = egg_groups[0]["name"] as! String
                    self.eggGroup_1.text = egg_group.capitalized
                    self.eggGroup_2.isHidden = true
                } else{
                    let egg_group = egg_groups[0]["name"] as! String
                    self.eggGroup_1.text = egg_group.capitalized
                    let egg_group_2 = egg_groups[1]["name"] as! String
                    self.eggGroup_2.text = egg_group_2.capitalized
                }
            }
            //hatch
            let hatch_counter = array["hatch_counter"] as! Int
            let steps = 255*(hatch_counter+1)
            stepsHatch.text = "\(steps) Steps"
            cyclesHatch.text = "\(hatch_counter) Cycles"
            
            //Gender
            let gender_rate = array["gender_rate"] as! Int
            if gender_rate == -1 {
                female_gender.isHidden = true
            }else{
                let chance_female = Float(gender_rate)/8.0
                let chance_male = 1.0 - chance_female
                
                male_gender.text = "\(Float(chance_male*100.0)) %"
                female_gender.text = "\(Float(chance_female*100.0)) %"
            }
            
            //Habitat
            let habitat = array["habitat"] as! [String:Any]
            habitatLabel.text = (habitat["name"] as! String).capitalized

            //Generation
            let generation = array["generation"] as! [String:Any]
            generationLabel.text = (generation["name"] as! String).capitalized

            //Capture Rate
            
            let capture_rate = array["capture_rate"] as! Int
            let rate = String(format: "%.2f", (Float(capture_rate)/255.0)*100)
            
            ratioCatchLabel.text = "\(rate) %"
            getEvolutions()
        }
    }
    @IBOutlet weak var heightTableViewConstrain: NSLayoutConstraint!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewAbilities {
            if data.count > 0 {
                let count = (data["abilities"] as!  [[String:Any]]).count
                return count
            }else{
                return 0
            }
        }
        else{
            if evolution.count > 0{
                return evolution.count - 1
            }else{
                return 0
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewAbilities {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonSingleTableViewCell", for: indexPath) as! PokemonSingleTableViewCell
            let abilities = data["abilities"] as!  [[String:Any]]
            let row = abilities[indexPath.row]
            let ability = row["ability"] as! [String:Any]
            let hidden = row["is_hidden"] as! Int
            if hidden == 1{
                cell.imageHide.isHidden = false
            }else{
                cell.imageHide.isHidden = true
            }
            cell.titleLabel.text = (ability["name"] as? String ?? "").capitalized
            cell.titleLabel.textColor = Utils.getColorByType(type: principal_type)
            cell.url = ability["url"] as? String ?? ""
            cell.cargarInfo()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonEvolutionViewCell", for: indexPath) as! PokemonEvolutionTableViewCell
            
            let pokeSource = evolution[indexPath.row] as! [String:Any]
            
            let pokeDest = evolution[indexPath.row + 1]
            
            let specieSource = pokeSource["species"] as! [String:Any]
            cell.pokemonOrigenName.text = (specieSource["name"] as! String).capitalized
            
            let specieDest = pokeDest["species"] as! [String:Any]
            cell.pokemonEvolucionName.text = (specieDest["name"] as! String).capitalized
            
            let evolution_details = pokeDest["evolution_details"] as! [[String:Any]]
            
            for detail in evolution_details {
                cell.levelLabel.text = "Lv. \(detail["min_level"] as! Int)"
                break
            }
            
            
            return cell
        }
        
    }
    
    func getEvolutions(){
        if let evolution_chain = poke_species["evolution_chain"] as? [String:Any] {
            let url:String = evolution_chain["url"] as! String
            AF.request("\(url)",headers: [
                "Content-Type": "application/json",
                "Accept": "application/json",
            ]).validate(statusCode: 200..<600)
                .responseJSON { response in
                    switch response.result
                    {
                    case .success:
                        if let json = response.value as? [String:Any] {
                            self.poke_evolutions = json
                            self.getVolutionFromArray(chain: self.poke_evolutions["chain"] as! [String : Any])
                            self.tableViewEvolutions.reloadData()
                        }
                    case .failure(let error):
                        print(error)
                    }
            }
        }
    }
    var evolution:[[String:Any]] = []
    
    func getVolutionFromArray(chain:[String:Any]){
        evolution.append(chain)
        if (chain["evolves_to"] as! [[String:Any]]).count == 0{
            return
        }else{
            for evol in chain["evolves_to"] as! [[String:Any]]{
                getVolutionFromArray(chain: evol)
            }
            
        }
    }
    @IBOutlet weak var viewStats: UIView!
    @IBOutlet weak var viewEvolutions: UIView!
    @IBOutlet weak var viewMoves: UIView!
    
    @IBOutlet weak var buttonStats: UIButton!
    @IBOutlet weak var buttonEvolution: UIButton!
    @IBOutlet weak var buttonMoves: UIButton!

    @IBAction func buttonStats(_ sender: Any) {
        viewStats.isHidden = false
        viewEvolutions.isHidden = true
        viewMoves.isHidden = true
        customButton(button: buttonStats, active: 1)
        customButton(button: buttonEvolution, active: 0)
        customButton(button: buttonMoves, active: 0)

    }
    @IBAction func buttonEvolutions(_ sender: Any) {
        viewStats.isHidden = true
        viewEvolutions.isHidden = false
        viewMoves.isHidden = true
        customButton(button: buttonStats, active: 0)
        customButton(button: buttonEvolution, active: 1)
        customButton(button: buttonMoves, active: 0)
    }
    
    @IBAction func buttonMoves(_ sender: Any) {
        viewStats.isHidden = true
        viewEvolutions.isHidden = true
        viewMoves.isHidden = false
        customButton(button: buttonStats, active: 0)
        customButton(button: buttonEvolution, active: 0)
        customButton(button: buttonMoves, active: 1)
    }
    
    func customButton(button:UIButton, active:Int){
        if active == 1 {
            button.backgroundColor = Utils.getColorByType(type: principal_type)
            button.layer.cornerRadius = 19.31
            button.titleLabel?.textColor = UIColor.white
        }else{
            button.backgroundColor = .clear
            button.layer.cornerRadius = 19.31
            button.titleLabel?.textColor = Utils.getColorByType(type: principal_type)
        }
    }
}

