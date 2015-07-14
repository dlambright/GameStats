//
//  GameStatsConstants.swift
//  GameStats
//
//  Created by Charlie Buckets on 7/14/15.
//  Copyright (c) 2015 Charlie Buckets. All rights reserved.
//

import Foundation
import UIKit

var primaryColors:[String:UIColor] = ["AtlantaHawks": UIColor(red: 225/255 , green: 58/255 , blue: 62/255 , alpha: 1),
    "BostonCeltics": UIColor(red: 0/255 , green: 131/255 , blue: 72/255 , alpha: 1),
    "BrooklynNets": UIColor(red: 6/255 , green: 25/255 , blue: 34/255 , alpha: 1),
    "CharlotteHornets": UIColor(red: 29/255 , green: 17/255 , blue: 96/255 , alpha: 1),
    "ChicagoBulls": UIColor(red: 206/255 , green: 17/255 , blue: 65/255 , alpha: 1),
    "ClevelandCavaliers": UIColor(red: 134/255 , green: 0/255 , blue: 56/255 , alpha: 1),
    "DallasMavericks": UIColor(red: 0/255 , green: 125/255 , blue: 197/255 , alpha: 1),
    "DenverNuggets": UIColor(red: 77/255 , green: 144/255 , blue: 205/255 , alpha: 1),
    "DetroitPistons": UIColor(red: 237/255 , green: 23/255 , blue: 76/255 , alpha: 1),
    "GoldenStateWarriors": UIColor(red: 253/255 , green: 185/255 , blue: 39/255 , alpha: 1),
    "HoustonRockets": UIColor(red: 206/255 , green: 17/255 , blue: 65/255 , alpha: 1),
    "IndianaPacers": UIColor(red: 255/255 , green: 198/255 , blue: 51/255 , alpha: 1),
    "LosAngelesClippers": UIColor(red: 237/255 , green: 23/255 , blue: 76/255 , alpha: 1),
    "LosAngelesLakers": UIColor(red: 253/255 , green: 185/255 , blue: 39/255 , alpha: 1),
    "MemphisGrizzlies": UIColor(red: 15/255 , green: 88/255 , blue: 108/255 , alpha: 1),
    "MiamiHeat": UIColor(red: 152/255 , green: 0/255 , blue: 46/255 , alpha: 1),
    "MilwaukeeBucks": UIColor(red: 0/255 , green: 71/255 , blue: 27/255 , alpha: 1),
    "MinnesotaTimberwolves": UIColor(red: 0/255 , green: 80/255 , blue: 131/255 , alpha: 1),
    "NewOrleansPelicans": UIColor(red: 0/255 , green: 43/255 , blue: 92/255 , alpha: 1),
    "NewYorkKnicks": UIColor(red: 245/255 , green: 132/255 , blue: 38/255 , alpha: 1),
    "OklahomaCityThunder": UIColor(red: 0/255 , green: 125/255 , blue: 197/255 , alpha: 1),
    "OrlandoMagic": UIColor(red: 0/255 , green: 125/255 , blue: 197/255 , alpha: 1),
    "Philadelphia76ers": UIColor(red: 237/255 , green: 23/255 , blue: 76/255 , alpha: 1),
    "PhoenixSuns": UIColor(red: 229/255 , green: 96/255 , blue: 32/255 , alpha: 1),
    "PortlandTrailblazers": UIColor(red: 225/255 , green: 58/255 , blue: 62/255 , alpha: 1),
    "SacramentoKings": UIColor(red: 114/255 , green: 76/255 , blue: 159/255 , alpha: 1),
    "SanAntonioSpurs": UIColor(red: 186/255 , green: 195/255 , blue: 201/255 , alpha: 1),
    "TorontoRaptors": UIColor(red: 206/255 , green: 17/255 , blue: 65/255 , alpha: 1),
    "UtahJazz": UIColor(red: 0/255 , green: 43/255 , blue: 92/255 , alpha: 1),
    "WashingtonWizards": UIColor(red: 0/255 , green: 43/255 , blue: 92/255 , alpha: 1)]
var secondaryColors:[String:UIColor] = ["AtlantaHawks": UIColor(red: 0, green: 43/255, blue: 92/255, alpha: 1),
    "ChicagoBulls": UIColor(red: 6/255, green: 25/255, blue: 34/255, alpha: 1),
    "DallasMavericks": UIColor(red: 196/255, green: 206/255, blue: 211/255, alpha: 1),
    "DetriotPistons": UIColor(red: 237/255, green: 23/255, blue: 76/255, alpha: 1),
    "GoldenStateWarriors": UIColor(red: 253/255, green: 185/255, blue: 39/255, alpha: 1),
    "HoustonRockets": UIColor(red: 206/255, green: 17/255, blue: 65/255, alpha: 1),
    "LosAngelesClippers": UIColor(red: 237/255, green: 23/255, blue: 76/255, alpha: 1),
    "LosAngelesLakers": UIColor(red: 85/255, green: 37/255, blue: 130/255, alpha: 1),
    "NewOrleansPelicans": UIColor(red: 227/255, green: 24/255, blue: 55/255, alpha: 1),
    "OklahomaCityThunder": UIColor(red: 240/255, green: 81/255, blue: 51/255, alpha: 1),
    "OrlandoMagic": UIColor(red: 196/255, green: 206/255 , blue: 211/255, alpha: 1),
    "Philadelphia76ers": UIColor(red: 0, green: 107/255, blue: 182/255, alpha: 1),
    "PortlandTrailblazers": UIColor(red: 186/255, green: 195/255, blue: 201/255, alpha: 1),
    "TorontoRaptors": UIColor(red: 6/255, green: 25/255, blue: 34/255, alpha: 1),
    "UtahJazz": UIColor(red: 249/255, green: 160/255, blue: 27/255, alpha: 1),
    "WashingtonWizards": UIColor(red: 227/255, green: 24/255, blue: 55/255, alpha: 1)]

var teamNameTable: [String:String] = ["AtlantaHawks": "Hawks",
    "BostonCeltics": "Celtics",
    "BrooklynNets": "Nets",
    "CharlotteHornets": "Hornets",
    "ChicagoBulls": "Bulls",
    "ClevelandCavaliers": "Cavaliers",
    "DallasMavericks": "Mavericks",
    "DenverNuggets": "Nuggets",
    "DetroitPistons": "Pistons",
    "GoldenStateWarriors": "Warriors",
    "HoustonRockets": "Rockets",
    "IndianaPacers": "Pacers",
    "LosAngelesClippers": "Clippers",
    "LosAngelesLakers": "Lakers",
    "MemphisGrizzlies": "Grizzlies",
    "MiamiHeat": "Heat",
    "MilwaukeeBucks": "Bucks",
    "MinnesotaTimberwolves": "Timberwolves",
    "NewOrleansPelicans": "Pelicans",
    "NewYorkKnicks": "Knicks",
    "OklahomaCityThunder": "Thunder",
    "OrlandoMagic": "Magic",
    "Philadelphia76ers": "76ers",
    "PhoenixSuns": "Suns",
    "PortlandTrailblazers": "Trail Blazers",
    "SacramentoKings": "Kings",
    "SanAntonioSpurs": "Spurs",
    "TorontoRaptors": "Raptors",
    "UtahJazz": "Jazz",
    "WashingtonWizards": "Wizards"]

func getTeamNameOnly(teamURL : String)->String{
    return teamNameTable[teamURL]!
}

    